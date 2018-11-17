//
//  CreateBubblePopup.swift
//  Jam
//
//  Created by Cooper Barth on 11/17/18.
//  Copyright © 2018 Cooper Barth. All rights reserved.
//

import UIKit

class CreateBubblePopup: UIViewController {
    @IBOutlet weak var CreateView: UIView!
    var tapOutside: UITapGestureRecognizer = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapOutside = UITapGestureRecognizer()
        self.view.addGestureRecognizer(self.tapOutside)
        self.setUpUI()
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
