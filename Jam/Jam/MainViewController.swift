//
//  MainViewController.swift
//  Jam
//
//  Created by Cooper Barth on 11/12/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit
import MediaPlayer

class MainViewController: SWRevealViewController {
    @IBOutlet weak var NavItem: UINavigationItem!
    var touchGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    let nodeSize: CGFloat = UIScreen.main.bounds.width / 20

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.touchGesture = UITapGestureRecognizer(target: self, action: #selector(self.addBubble(_ :)))
        self.view.addGestureRecognizer(self.touchGesture)
    }

    func setUpUI() {
        self.view.isUserInteractionEnabled = true
        self.view.backgroundColor = .white
        let revealViewController: SWRevealViewController? = self.revealViewController()
        if revealViewController != nil {
            let image = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
            self.NavItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: revealViewController, action: #selector(self.revealToggle(_:)))
            self.view.addGestureRecognizer(revealViewController!.tapGestureRecognizer())
        }
    }

    @objc func addBubble(_ sender: UITapGestureRecognizer) {
        let beatNode = UIImage(color: .red, size: CGSize(width: nodeSize, height: nodeSize))
        let beatNodeView = SongBubble(image: beatNode)
        var loc = sender.location(in: self.view)
        loc.x -= nodeSize
        loc.y -= nodeSize

        beatNodeView.frame = CGRect(origin: loc, size: beatNode.size)
        beatNodeView.layer.cornerRadius = 10.0
        beatNodeView.layer.masksToBounds = true
        beatNodeView.isUserInteractionEnabled = true

        self.view.addSubview(beatNodeView)
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
