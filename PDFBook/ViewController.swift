//
//  ViewController.swift
//  PDFBook
//
//  Created by Roselle Tanner on 3/19/17.
//  Copyright © 2017 Roselle Tanner. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // make views
        let view1 = SmallBookletView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view1)
        let view2 = MediumBookletView()
        view2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view2)
        let views = [view1, view2]
        
        // add constraints
        let vertical = NSLayoutConstraint.bindVertically(views)
        let widthHeight = NSLayoutConstraint.equalWidthsAndHeights(views)
        let horizontal = NSLayoutConstraint.bindLeftRight(view1) + NSLayoutConstraint.bindLeftRight(view2)
        NSLayoutConstraint.activate(vertical + widthHeight + horizontal)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window!.title = "PDFBook"
    }
}

