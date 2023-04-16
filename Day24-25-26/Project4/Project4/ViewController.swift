//
//  ViewController.swift
//  Project4
//
//  Created by Nicholas on 16/04/2023.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webview: WKWebView!
    
    let websites: [String: UIAlertAction.Style] = [
        "apple.com": .default,
        "hackingwithswift.com": .default,
        "notnick.io": .default
    ]
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let url = URL(string: "https://www.hackingwithswift.com")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://\(action.title!)")!
        webview.load(URLRequest(url: url))
    }

    @objc func openTapped() {

        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)

        for website in websites {
            ac.addAction(UIAlertAction(title: website.key, style: website.value, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // Important for iPads
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
