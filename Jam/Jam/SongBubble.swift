//
//  SongBubble.swift
//  Jam
//
//  Created by Cooper Barth on 11/17/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit
import MediaPlayer

class SongBubble: UIImageView {
    var longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    var singleTouchGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    var doubleTouchGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    var moveGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    var pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer()
    var rotationGesture: UIRotationGestureRecognizer = UIRotationGestureRecognizer()

    var songPlayer: MPMusicPlayerController = MPMusicPlayerController.applicationQueuePlayer
    var masterVolumeSlider: MPVolumeView = MPVolumeView(frame: .zero)

    var lastSize: CGSize = CGSize()
    var playback: Float = 1.0

    override func didMoveToSuperview() {
        self.setUpTaps()
        MainViewController.v.addSubview(self.masterVolumeSlider)
        self.lastSize = self.frame.size
    }

    func setUpTaps() {
        self.longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.fireLongPress(_:)))
        self.longPressGesture.allowableMovement = 20
        self.longPressGesture.minimumPressDuration = 0.35
        self.addGestureRecognizer(self.longPressGesture)

        self.singleTouchGesture = UITapGestureRecognizer(target: self, action: #selector(self.fireSingleTap(_:)))
        self.singleTouchGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(self.singleTouchGesture)

        self.doubleTouchGesture = UITapGestureRecognizer(target: self, action: #selector(self.fireDoubleTap(_ :)))
        self.doubleTouchGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(self.doubleTouchGesture)

        self.moveGesture = UIPanGestureRecognizer(target: self, action: #selector(self.fireMove(_ :)))
        self.addGestureRecognizer(self.moveGesture)

        self.pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.firePinch(_:)))
        self.addGestureRecognizer(self.pinchGesture)

        self.rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(self.fireRotation(_:)))
        self.addGestureRecognizer(self.rotationGesture)
    }

    @objc func fireLongPress(_ sender: UILongPressGestureRecognizer) {
        print("Long Press")
    }

    @objc func fireSingleTap(_ sender: UITapGestureRecognizer) {
        if (self.songPlayer.playbackState == .playing) {
            self.songPlayer.pause()
        } else {
            self.songPlayer.play()
            self.songPlayer.currentPlaybackRate = playback
        }
    }

    @objc func fireDoubleTap(_ sender: UITapGestureRecognizer) {
        self.songPlayer.stop()
        SideMenu.musicChosen = false
        self.removeFromSuperview()
    }

    @objc func fireMove(_ sender: UIPanGestureRecognizer) {
        let bubbleView = sender.view!
        let translation = sender.translation(in: self)
        bubbleView.center = CGPoint(x: bubbleView.center.x + translation.x, y: bubbleView.center.y + translation.y)
        sender.setTranslation(.zero, in: self)
    }

    @objc func firePinch(_ sender: UIPinchGestureRecognizer) {
        let newWidth = self.lastSize.width * sender.scale.magnitude
        let newHeight = self.lastSize.height * sender.scale.magnitude
        let noSmaller: Bool = newWidth < self.lastSize.width && self.frame.size.width <= UIScreen.main.bounds.width / 5
        let noBigger: Bool = newWidth > self.lastSize.width && self.frame.size.width >= UIScreen.main.bounds.width / 3
        if !(noSmaller || noBigger) {
            let oldx = self.frame.size.width
            let oldy = self.frame.size.height
            self.frame.size.width = newWidth
            self.frame.size.height = newHeight
            self.frame.origin.x -= (self.frame.size.width - oldx) / 2
            self.frame.origin.y -= (self.frame.size.height - oldy) / 2
        }

        if let view = masterVolumeSlider.subviews.first as? UISlider {
            /*
             Want scale to be based on min to max value
             volume value = 0.1 min, 1.0 max -> 0.9 increase
             raw increase is 1/3-1/5 = 5/15-3/15 = 2/15

             when size=3/15, vol=0.1
             when size=5/15, vol=1
            */
            let scaledSize = self.frame.size.width / UIScreen.main.bounds.width * 3
            view.value = Float(scaledSize)
        }

        if (sender.state == UIGestureRecognizer.State.ended) {
            self.lastSize = self.frame.size
        }
    }

    @objc func fireRotation(_ sender: UIRotationGestureRecognizer) {
        let rot = sender.rotation
        if (songPlayer.currentPlaybackRate >= 2.0 && rot > 0) {return}
        if (songPlayer.currentPlaybackRate <= 0.5 && rot < 0) {return}
        songPlayer.currentPlaybackRate += 0.1 * Float(rot)
        if (songPlayer.currentPlaybackRate < 0.5) {songPlayer.currentPlaybackRate = 0.5}
        if (songPlayer.currentPlaybackRate > 2.0) {songPlayer.currentPlaybackRate = 2.0}
        self.playback = songPlayer.currentPlaybackRate
        self.transform = self.transform.rotated(by: rot)
    }
}
