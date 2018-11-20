//
//  CreateBubblePopup.swift
//  Jam
//
//  Created by Cooper Barth on 11/17/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit
import MediaPlayer

class CreateBubblePopup: UIViewController, MPMediaPickerControllerDelegate {
    @IBOutlet weak var CreateView: UIView!
    var tapOutside: UITapGestureRecognizer = UITapGestureRecognizer()
    let nodeSize: CGFloat = UIScreen.main.bounds.width / 20

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.tapOutside = UITapGestureRecognizer()
        self.view.addGestureRecognizer(self.tapOutside)
    }

    @IBAction func addMusic(_ sender: Any) {
        let songPicker = MPMediaPickerController(mediaTypes: .music)
        songPicker.allowsPickingMultipleItems = false
        songPicker.popoverPresentationController?.sourceView = self.view
        songPicker.delegate = self
        self.present(songPicker, animated: true, completion: nil)
    }

    func addBubble() {
        let beatNode = UIImage(color: .red, size: CGSize(width: nodeSize, height: nodeSize))
        let beatNodeView = SongBubble(image: beatNode)

        beatNodeView.frame = CGRect(origin: MainViewController.mostRecentTap, size: beatNode.size)
        beatNodeView.layer.cornerRadius = 10.0
        beatNodeView.layer.masksToBounds = true
        beatNodeView.isUserInteractionEnabled = true

        MainViewController.v.addSubview(beatNodeView)
    }

    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        self.addBubble()
        mediaPicker.dismiss(animated: true, completion: nil)

        MainViewController.songPlayer.setQueue(with: mediaItemCollection)
        MainViewController.songPlayer.play()
    }

    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }

    func setUpUI() {
        self.CreateView.layer.cornerRadius = 10
        self.CreateView.layer.masksToBounds = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let loc = touch?.location(in: self.view)
        if (!self.CreateView.frame.contains(loc!)) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
