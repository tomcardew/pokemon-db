//
//  WebViewController.swift
//  pokemon-db
//
//  Created by Admin on 25/06/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let site = URL(string: url!)
        webView.load(URLRequest(url: site!))
    }
    
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openBrowserPressed(_ sender: Any) {
        if let url = URL(string: url!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
