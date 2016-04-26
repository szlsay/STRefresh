//
//  ViewController.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/11.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.magentaColor()
        delay(2.0, closure: { () -> () in })      
    }
}

