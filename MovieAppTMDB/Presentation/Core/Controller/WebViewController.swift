//
//  WebViewController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 27.01.25.
//

import Foundation
import WebKit

final class WebViewController: BaseController {
    
    private lazy var webView: WKWebView = {
        let web = WKWebView()
        return web
    }()
    
    private var url: URL?
    
    init(url: String) {
        self.url = URL(string: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(webView)
        guard let url = url else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.fillSuperviewSafeAreaLayoutGuide()
    }
     
}
