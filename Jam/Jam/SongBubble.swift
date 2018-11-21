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
    var doubleTouchGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    var moveGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    var songPlayer: MPMusicPlayerController = MPMusicPlayerController.applicationQueuePlayer
    var masterVolumeSlider: MPVolumeView = MPVolumeView(frame: .zero)

    override func didMoveToSuperview() {
        self.setUpTaps()
        MainViewController.v.addSubview(self.masterVolumeSlider)
    }

    func setUpTaps() {
        self.longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.fireLongPress(_:)))
        self.longPressGesture.allowableMovement = 20
        self.longPressGesture.minimumPressDuration = 0.35
        self.addGestureRecognizer(self.longPressGesture)

        self.doubleTouchGesture = UITapGestureRecognizer(target: self, action: #selector(self.doubleTappedView(_ :)))
        self.doubleTouchGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(self.doubleTouchGesture)

        self.moveGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_ :)))
        self.addGestureRecognizer(self.moveGesture)
    }

    @objc func fireLongPress(_ sender: UILongPressGestureRecognizer) {
        if (sender.state == UIGestureRecognizer.State.began) {
            print("Long Press!")
            if let view = masterVolumeSlider.subviews.first as? UISlider {
                view.value += 0.5
            }
        }
    }

    @objc func doubleTappedView(_ sender: UITapGestureRecognizer) {
        self.songPlayer.stop()
        SideMenu.musicChosen = false
        self.removeFromSuperview()
    }

    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        let bubbleView = sender.view!
        let translation = sender.translation(in: self)
        bubbleView.center = CGPoint(x: bubbleView.center.x + translation.x, y: bubbleView.center.y + translation.y)
        sender.setTranslation(.zero, in: self)
    }
}
