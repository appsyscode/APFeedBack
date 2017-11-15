//
//  ViewController.swift
//  APFeedBackSwift
//
//  Created by Parti Albert on 2017. 11. 15..
//  Copyright © 2017. devalios. All rights reserved.
//

import UIKit
import APFeedBack
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Hello Swift viewDidLoad")
        NSLog("txt log viewDidLoad")

        let fd = APFeedTableViewController()
        fd.developer_LogFile = true
        fd.mailHTML = true
        navigationController?.pushViewController(fd as? UIViewController ?? UIViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

