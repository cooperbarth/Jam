//
//  RootViewController.swift
//  Jam
//
//  Created by Cooper Barth on 11/12/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit

class MainViewController: SWRevealViewController {

    @IBOutlet weak var menuButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpRevealViewController()
        view.backgroundColor = .white
    }

    func setUpRevealViewController() {
        let revealViewController: SWRevealViewController? = self.revealViewController()
        if revealViewController != nil {
            menuButton.target = revealViewController
            menuButton.action = #selector(self.revealToggle(_:))
            view.addGestureRecognizer(revealViewController!.tapGestureRecognizer())
        }
    }
}
