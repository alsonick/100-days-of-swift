//
//  DetailViewController.swift
//  Project7
//
//  Created by Nicholas on 26/04/2023.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style> body { font-size: 150%; padding-left: 2%; padding-right: 2%; } h1 { font-size: 30px; } p { font-size: 15px; color: #006666 } </style>
            </head>
            <body>
                <h1>
                    \(detailItem.title)
                </h1>
                <p>
                    \(detailItem.body)
                </p>
            </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

}
