//
//  MainViewController.swift
//  Jam
//
//  Created by Cooper Barth on 11/12/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit
import MediaPlayer

class MainViewController: SWRevealViewController, MPMediaPickerControllerDelegate {
    static var v: UIView = UIView()
    let nodeSize: CGFloat = UIScreen.main.bounds.width / 20
    @IBOutlet weak var NavItem: UINavigationItem!
    var touchGesture: UITapGestureRecognizer = UITapGestureRecognizer()

    static var songPlayer: MPMusicPlayerController = MPMusicPlayerController.applicationQueuePlayer

    static var mostRecentView: SongBubble = SongBubble()
    static var mostRecentTap: CGPoint = CGPoint()

    var songCount: Int = 0
    var beatCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.touchGesture = UITapGestureRecognizer(target: self, action: #selector(self.showCreateBubble(_ :)))
        self.view.addGestureRecognizer(self.touchGesture)
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

    @objc func showCreateBubble(_ sender: UITapGestureRecognizer) {
        var loc = sender.location(in: self.view)
        loc.x -= nodeSize
        loc.y -= nodeSize
        MainViewController.mostRecentTap = loc

        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateBubblePopup") {
            vc.modalPresentationStyle = .overCurrentContext
            vc.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.75)
            self.present(vc, animated: false, completion: nil)
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
