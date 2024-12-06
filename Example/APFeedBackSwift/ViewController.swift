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

    }
    @IBAction func openPushViewController(_ sender: UIButton) {
        let fd = APFeedTableViewController()
        fd.developer_LogFile = true
        fd.mailHTML = true
        navigationController?.pushViewController(fd, animated: true)
    }
    @IBAction func openModalViewController(_ sender: UIButton) {
        let fd = APFeedTableViewController()
        fd.developer_LogFile = true
        fd.mailHTML = true
        fd.modalPresentationStyle = .formSheet
        present(fd, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

