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
    static var v: UIView = UIView()

    static var musicNode: SongBubble = SongBubble()
    static var mostRecentTap: CGPoint = CGPoint()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        MainViewController.v = self.view
        self.firstTimeLaunch() ? self.tutorial() : nil
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

    func firstTimeLaunch() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil {
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            return false
        }
    }

    func tutorial() {
        //tutorial!
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
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
