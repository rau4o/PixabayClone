//
//  WebController.swift
//  PixabayApp
//
//  Created by rau4o on 6/9/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import WebKit

class WebController: UIViewController {
    
    // MARK: - Properties
    
    static let shared = WebController()
    var webView = WKWebView()
    var urlString: String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        addNavigationBarButtonItem()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
        loadUrl()
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadUrl() {
        guard let url = URL(string: urlString ?? "") else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func stopLoading() {
        webView.removeFromSuperview()
        navigationController?.popViewController(animated: true)
    }
    
    private func addNavigationBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelButton(sender:)))
    }
    
    // MARK: - Selectors
    
    @objc func handleCancelButton(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension WebController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        print("request: \(request.description)")
        if request.description == urlString{
            //do close window magic here!!
            print("url matches...")
            stopLoading()
            return false
        }
        return true
    }
}
