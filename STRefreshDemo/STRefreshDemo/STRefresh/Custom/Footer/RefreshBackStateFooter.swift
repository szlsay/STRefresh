//
//  RefreshBackStateFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class RefreshBackStateFooter: RefreshBackFooter {

    /** 显示刷新状态的label */
    var stateLabel: UILabel!
    
    /** 所有状态对应的文字 */
    var stateTitles = [RefreshState: String]()
    
    /** 设置state状态下的文字 */
    func setTitle(title: String, state: RefreshState) {
        stateTitles[state] = title
        stateLabel.text = stateTitles[self.state]
    }
    
    /** 获取state状态下的title */
    func titleForState(state: RefreshState) -> String? {
        return stateTitles[state]
    }
    
    // MARK: - 重写父类的方法
    override func prepare() {
        super.prepare()
        
        stateLabel = UILabel.genLabel()
        addSubview(stateLabel)
        
        // 初始化文字
        setTitle(RefreshBackFooterIdleText, state: RefreshState.Idle)
        setTitle(RefreshBackFooterPullingText, state: RefreshState.Pulling)
        setTitle(RefreshBackFooterRefreshingText, state: RefreshState.Refreshing)
        setTitle(RefreshBackFooterNoMoreDataText, state: RefreshState.NoMoreData)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        if stateLabel.constraints.count > 0 {
            return
        }
        
        // 状态标签
        stateLabel.frame = bounds
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
            
            // 设置状态文字
            stateLabel.text = stateTitles[state]
        }
    }
}
