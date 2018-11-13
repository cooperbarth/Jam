//
//  CustomNavController.swift
//  Jam
//
//  Created by Cooper Barth on 11/13/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit

class CustomNavController: UINavigationController {

    @IBOutlet weak var NavBar: UINavigationBar!

    override func viewDidLoad() {
        self.NavBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.NavBar.shadowImage = UIImage()
        self.NavBar.isTranslucent = true
    }
}
