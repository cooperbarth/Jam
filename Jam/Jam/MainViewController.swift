//
//  RootViewController.swift
//  Jam
//
//  Created by Cooper Barth on 11/12/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit

class MainViewController: SWRevealViewController {

    @IBOutlet weak var NavItem: UINavigationItem!
    @IBOutlet weak var menuButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    func setUp() {
        view.backgroundColor = .white
        let revealViewController: SWRevealViewController? = self.revealViewController()
        if revealViewController != nil {
            let image = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
            self.NavItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: revealViewController, action: #selector(self.revealToggle(_:)))
            view.addGestureRecognizer(revealViewController!.tapGestureRecognizer())
        }
    }
}
