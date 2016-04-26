//
//  WebViewController.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/12.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    // MARK: - --- interface 接口

    // MARK: - --- lift cycle 生命周期 ---

    // MARK: - --- delegate 视图委托 ---

    // MARK: - --- event response 事件相应 ---

    // MARK: - --- private methods 私有方法 ---

    // MARK: - --- setters 属性 ---

    // MARK: - --- getters 属性 ---
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.frame = self.view.bounds
        return webView
    }()

//    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)

        // 加载页面
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://china.huanqiu.com/article/2016-04/8822504.html?from=bdwz")!))
        
        webView.delegate = self
        
        webView.scrollView.refreshHeader = RefreshNormalHeader() {
            self.webView.reload()
        }
        
        // 如果是上拉刷新，就以此类推
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension WebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.scrollView.refreshHeader.endRefreshing()
    }
}
