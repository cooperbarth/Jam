//
//  SongBubble.swift
//  Jam
//
//  Created by Cooper Barth on 11/17/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit

class SongBubble: UIImageView {
    var singleTouchGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    var doubleTouchGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    var moveGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    var identifier: Int = 0

    override func didMoveToSuperview() {
        self.setUpTaps()
    }

    func setUpTaps() {
        self.singleTouchGesture = UITapGestureRecognizer(target: self, action: #selector(self.singleTappedView(_ :)))
        self.singleTouchGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(self.singleTouchGesture)

        self.doubleTouchGesture = UITapGestureRecognizer(target: self, action: #selector(self.doubleTappedView(_ :)))
        self.doubleTouchGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(self.doubleTouchGesture)

        self.moveGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_ :)))
        self.addGestureRecognizer(self.moveGesture)
    }

    @objc func singleTappedView(_ sender: UITapGestureRecognizer) {
        print("single tapped")
    }
    
    @objc func doubleTappedView(_ sender: UITapGestureRecognizer) {
        print("double tapped")
    }

    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        let bubbleView = sender.view!
        let translation = sender.translation(in: self)
        bubbleView.center = CGPoint(x: bubbleView.center.x + translation.x, y: bubbleView.center.y + translation.y)
        sender.setTranslation(.zero, in: self)
    }
}
