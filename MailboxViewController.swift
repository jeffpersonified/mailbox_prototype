//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Jeff Smith on 9/28/14.
//  Copyright (c) 2014 Jeff Smith. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var inboxScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inboxScrollView.contentSize = CGSize(width: 320, height: (1202 + 86 + 37 + 42))
        
    }
    
}
