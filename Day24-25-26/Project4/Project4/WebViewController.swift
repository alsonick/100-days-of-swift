//
//  WebViewController.swift
//  Project4
//
//  Created by Nicholas on 18/04/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webview: WKWebView!
    var progressView: UIProgressView!
    
    var selectedWebsite: String?

    @IBOutlet var tableView: UITableView!
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
        
        let url: URL?
        
        if let website = selectedWebsite {
            url = URL(string: "https://\(website)")!
        } else {
            url = URL(string: "https://\(Constants.safe[0])")!
        }
        
        navigationItem.largeTitleDisplayMode = .never
        webview.load(URLRequest(url: url!))
        webview.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {

        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)

        for website in Constants.websites {
            ac.addAction(UIAlertAction(title: website.key, style: website.value, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // Important for iPads
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action: #selector(webview.reload))
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(webview.goBack))
        let forwardButton = UIBarButtonItem(title: "Forward", style: .plain, target: nil, action: #selector(webview.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, backButton, forwardButton, refresh]
        navigationController?.isToolbarHidden = false
        
        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://\(action.title!)")!
        webview.load(URLRequest(url: url))
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webview.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in Constants.websites {
                if host.contains(website.key) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        let alert = UIAlertController(title: "Website Blocked", message: "This website that you're trying to navigate to is blocked.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
        
        decisionHandler(.cancel)
    }
}
