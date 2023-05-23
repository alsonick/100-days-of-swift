//
//  WebViewController.swift
//  Project16
//
//  Created by Nicholas on 23/05/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webview: WKWebView!
    var city: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
        
        let url: URL?
        
        if let location = city {
            url = URL(string: "https://en.wikipedia.org/wiki/\(location)")
        } else {
            url = URL(string: "https://en.wikipedia.org/wiki/London")
        }
        
        webview.load(URLRequest(url: url!))
        webview.allowsBackForwardNavigationGestures = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
