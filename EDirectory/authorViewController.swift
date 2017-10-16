//
//  authorViewController.swift
//  EDirectory
//
//  Created by Kartheek chintalapati on 15/10/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//
/************************************************************************************
 This view shows a web view which displays a web page about the author.
 ************************************************************************************/

import UIKit

class authorViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "/html/index", ofType: "html")!
        let data:NSData = NSData(contentsOfFile:path)!
        let html = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        
        // Load the webView outlet with the content of the index.html file
        webView.loadHTMLString(html! as String, baseURL: Bundle.main.bundleURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
