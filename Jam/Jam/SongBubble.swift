//
//  SongBubble.swift
//  Jam
//
//  Created by Cooper Barth on 11/17/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit

class SongBubble: UIImageView {
    var moveGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    var touchGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override func didMoveToSuperview() {
        self.touchGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedView(_ :)))
        self.addGestureRecognizer(self.touchGesture)
        self.moveGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_ :)))
        self.addGestureRecognizer(self.moveGesture)
    }
    
    @objc func tappedView(_ sender: UITapGestureRecognizer) {
        print("tapped")
    }
    
    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        let bubbleView = sender.view!
        let translation = sender.translation(in: self)
        bubbleView.center = CGPoint(x: bubbleView.center.x + translation.x, y: bubbleView.center.y + translation.y)
        sender.setTranslation(.zero, in: self)
    }
}
