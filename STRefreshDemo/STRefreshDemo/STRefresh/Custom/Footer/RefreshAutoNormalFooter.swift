//
//  RefreshAutoNormalFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class RefreshAutoNormalFooter: RefreshAutoStateFooter {

    var loadingView: UIActivityIndicatorView!
    
    /** 菊花的样式 */
    var activityIndicatorViewStyle: UIActivityIndicatorViewStyle! {
        didSet {
            loadingView?.removeFromSuperview()
            
            loadingView = UIActivityIndicatorView(activityIndicatorStyle: activityIndicatorViewStyle)
            loadingView.hidesWhenStopped = true
            
            addSubview(loadingView)
            
            setNeedsLayout()
        }
    }
    
    override func prepare() {
        super.prepare()
        activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        if loadingView.constraints.count > 0 {
            return
        }
        
        // 圈圈
        var loadingCenterX = width * 0.5
        if !refreshingTitleHidden {
            loadingCenterX -= 100
        }
        let loadingCenterY = height * 0.5
        loadingView.center = CGPointMake(loadingCenterX, loadingCenterY)
    }
    
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if newValue == state {
                return
            }
            super.state = newValue
            
            // 根据状态做事情
            if state == .NoMoreData || state == .Idle {
                loadingView.stopAnimating()
            } else if state == .Refreshing {
                loadingView.startAnimating()
            }
        }
    }

}
