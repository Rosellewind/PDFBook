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

        // stackView
        let view1 = SmallBookletView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        let view2 = MediumBookletView()
        view2.translatesAutoresizingMaskIntoConstraints = false
        let views = [view1, view2]
        let stackView = NSStackView(views: views)
        stackView.alignment = .centerX
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        let constraints = NSLayoutConstraint.bindTopBottomLeftRight(stackView)
        NSLayoutConstraint.activate(constraints)
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    
    
    

}

