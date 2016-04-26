//
//  RefreshAutoFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class DIYAutoFooter: RefreshAutoFooter {

    var label: UILabel!
    var s: UISwitch!
    var loading: UIActivityIndicatorView!
    
    // MARK: 在这里做一些初始化配置（比如添加子控件）
    override func prepare() {
        super.prepare()
        
        // 设置控件的高度
        height = 50
        
        // 添加label
        label = UILabel()
        label.textColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        label.font = UIFont.systemFontOfSize(16)
        label.textAlignment = NSTextAlignment.Center
        addSubview(label)
        
        // 打酱油的开关
        s = UISwitch()
        addSubview(s)
        
        // loading
        loading = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        addSubview(loading)
    }

    // MARK: 在这里设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()
        
        label.frame = bounds
        s.center = CGPointMake(width - 20, height - 20)
        loading.center = CGPointMake(30, height * 0.5)
    }
    
    // MARK: 监听scrollView的contentOffset改变
    override func scrollViewContentOffsetDidChange(change: NSDictionary?) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    // MARK: 监听scrollView的contentSize改变
    override func scrollViewContentSizeDidChange(change: NSDictionary?) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    // MARK: 监听scrollView的拖拽状态改变
    override func scrollViewPanStateDidChange(change: NSDictionary?) {
        super.scrollViewPanStateDidChange(change)
    }
    
    // MARK: 监听控件的刷新状态
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if newValue == super.state {
                return
            }
            super.state = newValue
            
            switch state {
            case .Idle:
                label.text = "赶紧上拉吖(开关是打酱油滴)"
                loading.stopAnimating()
                s.setOn(false, animated: true)

            case .Refreshing:
                s.setOn(true, animated: true)
                label.text = "加载数据中(开关是打酱油滴)"
                loading.startAnimating()

            case .NoMoreData:
                label.text = "木有数据了(开关是打酱油滴)"
                s.setOn(false, animated: true)
                loading.stopAnimating()

            default:
                break
            }
        }
    }
}
