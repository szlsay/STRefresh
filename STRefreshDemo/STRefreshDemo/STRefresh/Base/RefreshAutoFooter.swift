//
//  RefreshAutoFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class RefreshAutoFooter: RefreshFooter {

    /** 是否自动刷新(默认为YES) */
    var automaticallyRefresh = false
    
    /** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
    var appearencePercentTriggerAutoRefresh: CGFloat { //MJRefreshDeprecated("请使用automaticallyChangeAlpha属性");
        get {
            return triggerAutomaticallyRefreshPercent
        }
        set {
            triggerAutomaticallyRefreshPercent = newValue
        }
    }
    
    /** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
    var triggerAutomaticallyRefreshPercent: CGFloat = 0
    
    // MARK: - 初始化
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        
        if nil != newSuperview {
            if !hidden {
                scrollView.insetBottom += height
            }
            // 设置位置
            y = scrollView.contentHeight
        } else {
            if !hidden {
                scrollView.insetBottom -= height
            }
        }
    }

    // MARK: - 实现父类的方法
    override func prepare() {
        super.prepare()
        
        // 默认底部控件100%出现时才会自动刷新
        triggerAutomaticallyRefreshPercent = 1.0
        
        // 设置为默认状态
        automaticallyRefresh = true
    }
    
    override func scrollViewContentSizeDidChange(change: NSDictionary?) {
        super.scrollViewContentSizeDidChange(change)
        
        // 设置位置
        y = scrollView.contentHeight
    }
    
    override func scrollViewContentOffsetDidChange(change: NSDictionary?) {
        super.scrollViewContentOffsetDidChange(change)
        
        if state != .Idle || !automaticallyRefresh || y == 0 {
            return
        }
        
        if scrollView.insetTop + scrollView.contentHeight > scrollView.height { // 内容超过一个屏幕
            // 这里的_scrollView.mj_contentH替换掉self.mj_y更为合理
            if scrollView.offsetY >= scrollView.contentHeight - scrollView.height + height * triggerAutomaticallyRefreshPercent + scrollView.insetBottom - height {
                // 防止手松开时连续调用
                
                let old = change!["old"]!.CGPointValue
                let new = change!["new"]!.CGPointValue
                if new.y <= old.y {
                    return
                }
                
                // 当底部刷新控件完全出现时，才刷新
                beginRefreshing()
            }
        }
    }
    
    override func scrollViewPanStateDidChange(change: NSDictionary?) {
        super.scrollViewPanStateDidChange(change)
        
        if state != .Idle {
            return
        }
        
        if scrollView.panGestureRecognizer.state == UIGestureRecognizerState.Ended {// 手松开
            if scrollView.insetTop + scrollView.contentHeight <= scrollView.height {  // 不够一个屏幕
                if scrollView.offsetY >= -scrollView.insetTop { // 向上拽
                    beginRefreshing()
                }
            } else { // 超出一个屏幕
                if scrollView.offsetY >= scrollView.contentHeight + scrollView.insetBottom - scrollView.height {
                    beginRefreshing()
                }
            }
        }
    }
    
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if newValue == super.state {
                return
            }
            super.state = newValue
            
            if state == .Refreshing {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                    self.executeRefreshingCallback()
                }
            }
        }
    }
    
    override var hidden: Bool {
        get {
            return super.hidden
        }
        set {
            let lastHidden = super.hidden
            
            super.hidden = newValue
            
            if !lastHidden && hidden {
                state = .Idle
                
                scrollView.insetBottom -= height
                
            } else if lastHidden && !hidden {
                scrollView.insetBottom += height
                
                // 设置位置
                y = scrollView.contentHeight
            }
        }
    }
}
