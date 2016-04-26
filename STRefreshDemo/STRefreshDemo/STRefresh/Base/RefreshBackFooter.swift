//
//  RefreshBackFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class RefreshBackFooter: RefreshFooter {

    var lastRefreshCount = 0
    var lastBottomDelta: CGFloat = 0
    
    // MARK: - 初始化
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        
        scrollViewContentSizeDidChange(nil)
    }
    
    override func scrollViewContentOffsetDidChange(change: NSDictionary?) {
        super.scrollViewContentOffsetDidChange(change)
        
        // 如果正在刷新，直接返回
        if state == .Refreshing {
            return
        }
        
        scrollViewOriginalInset = scrollView.contentInset
        
        // 当前的contentOffset
        let currentOffsetY = scrollView.offsetY
        // 尾部控件刚好出现的offsetY
//        let happenOffsetY = self.happenOffsetY
        // 如果是向下滚动到看不见尾部控件，直接返回
        if currentOffsetY <= happenOffsetY {
            return
        }
        
        let pullingPercent = (currentOffsetY - happenOffsetY) / height
        
        // 如果已全部加载，仅设置pullingPercent，然后返回
        if state == .NoMoreData {
            self.pullingPercent = pullingPercent
            return
        }
        
        if scrollView.dragging {
            self.pullingPercent = pullingPercent
            // 普通 和 即将刷新 的临界点
            let normal2pullingOffsetY = happenOffsetY + height
            
            if self.state == .Idle && currentOffsetY > normal2pullingOffsetY {
                // 转为即将刷新状态
                state = .Pulling
                
            } else if self.state == .Pulling && currentOffsetY <= normal2pullingOffsetY {
                // 转为普通状态
                state = .Idle
            }
        } else if state == .Pulling {// 即将刷新 && 手松开
            // 开始刷新
            beginRefreshing()
            
        } else if pullingPercent < 1 {
            self.pullingPercent = pullingPercent
        }
    }
    
    override func scrollViewContentSizeDidChange(change: NSDictionary?) {
        super.scrollViewContentSizeDidChange(change)
        
        // 内容的高度
        let contentHeight = scrollView.contentHeight + ignoredScrollViewContentInsetBottom
        // 表格的高度
        let scrollHeight = scrollView.height - scrollViewOriginalInset.top - scrollViewOriginalInset.bottom + ignoredScrollViewContentInsetBottom
        // 设置位置和尺寸
        y = max(contentHeight, scrollHeight)
    }
    
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if super.state == newValue {
                return
            }
            let oldValue = state
            super.state = newValue
            
            // 根据状态来设置属性
            if newValue == .NoMoreData || newValue == .Idle {
                // 刷新完毕
                if .Refreshing == oldValue {
                    UIView.animateWithDuration(RefreshSlowAnimationDuration,
                        animations: {
                            self.scrollView.insetBottom -= self.lastBottomDelta
                            
                            // 自动调整透明度
                            if self.automaticallyChangeAlpha {
                                self.alpha = 0.0
                            }
                        }, completion: { flag in
                            self.pullingPercent = 0.0
                        }
                    )
                }
                
                let deltaH = heightForContentBreakView
                // 刚刷新完毕
                if .Refreshing == oldValue && deltaH > 0 && scrollView.totalDataCount != lastRefreshCount {
                    scrollView.offsetY = scrollView.offsetY
                }
                
            } else if newValue == .Refreshing {
                // 记录刷新前的数量
                lastRefreshCount = scrollView.totalDataCount
                
                UIView.animateWithDuration(RefreshFastAnimationDuration,
                    animations: {
                        var bottom = self.height + self.scrollViewOriginalInset.bottom
                        let deltaH = self.heightForContentBreakView
                        if deltaH < 0 { // 如果内容高度小于view的高度
                            bottom -= deltaH
                        }
                        self.lastBottomDelta = bottom - self.scrollView.insetBottom
                        self.scrollView.insetBottom = bottom
                        self.scrollView.offsetY = self.happenOffsetY + self.height
                        
                    }, completion: { result in
                        self.executeRefreshingCallback()
                    }
                )
            }
        }
    }
    
    // MARK: - 公共方法
    override func endRefreshing() {
        if scrollView is UICollectionView {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                super.endRefreshing()
            }
        } else {
            super.endRefreshing()
        }
    }
    
    override func noticeNoMoreData() {
        if scrollView is UICollectionView {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                super.noticeNoMoreData()
            }
        } else {
            super.noticeNoMoreData()
        }
    }
    
    // MARK: 获得scrollView的内容 超出 view 的高度
    var heightForContentBreakView: CGFloat {
        let h = scrollView.frame.size.height - scrollViewOriginalInset.bottom - scrollViewOriginalInset.top
        return scrollView.contentSize.height - h
    }
    
    // MARK: - 刚好看到上拉刷新控件时的contentOffset.y
    var happenOffsetY: CGFloat {
        let deltaH = heightForContentBreakView
        if deltaH > 0 {
            return deltaH - scrollViewOriginalInset.top
        } else {
            return -scrollViewOriginalInset.top
        }
    }

}
