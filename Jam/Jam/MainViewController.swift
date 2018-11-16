//
//  MainViewController.swift
//  Jam
//
//  Created by Cooper Barth on 11/12/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit
import MediaPlayer
import CoreGraphics

class MainViewController: SWRevealViewController {
    @IBOutlet weak var NavItem: UINavigationItem!
    let nodeSize: CGFloat = 25.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    func setUp() {
        self.view.isUserInteractionEnabled = true
        self.view.backgroundColor = .white
        let revealViewController: SWRevealViewController? = self.revealViewController()
        if revealViewController != nil {
            let image = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
            self.NavItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: revealViewController, action: #selector(self.revealToggle(_:)))
            view.addGestureRecognizer(revealViewController!.tapGestureRecognizer())
        }
    }

    func createShape(loc: CGPoint) {
        let beatNode = UIImage(color: .red, size: CGSize(width: nodeSize, height: nodeSize))
        let beatNodeView = SongBubble(image: beatNode)
        
        beatNodeView.frame = CGRect(origin: loc, size: beatNode.size)
        beatNodeView.layer.cornerRadius = 10.0
        beatNodeView.layer.masksToBounds = true
        beatNodeView.isUserInteractionEnabled = true

        self.view.addSubview(beatNodeView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        var loc = touch?.location(in: self.view)
        loc!.x -= nodeSize
        loc!.y -= nodeSize
        createShape(loc: loc!)
    }
}

class SongBubble: UIImageView {
    var panGesture = UIPanGestureRecognizer()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_ :)))
        self.addGestureRecognizer(self.panGesture)
    }
    
    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        let bubbleView = sender.view!
        let translation = sender.translation(in: self)
        bubbleView.center = CGPoint(x: bubbleView.center.x + translation.x, y: bubbleView.center.y + translation.y)
        sender.setTranslation(.zero, in: self)
    }
}

public extension UIImage {
    public convenience init(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let cgImage = image!.cgImage!
        self.init(cgImage: cgImage)
    }
}
