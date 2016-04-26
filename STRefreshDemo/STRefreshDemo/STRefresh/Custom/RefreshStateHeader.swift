//
//  RefreshStateHeader.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class RefreshStateHeader: RefreshHeader {

    // MARK: - 刷新时间相关
    /** 利用这个block来决定显示的更新时间文字 */
    var lastUpdatedTimeText: ((lastUpdatedTime: NSDate?) -> String)?
    
    /** 显示上一次刷新时间的label */
    var lastUpdatedTimeLabel: UILabel!
    
    // MARK: - 状态相关
    /** 显示刷新状态的label */
    var stateLabel: UILabel!
    
    /** 所有状态对应的文字 */
    var stateTitles = [RefreshState: String]()
    
    /** 设置state状态下的文字 */
    func setTitle(title: String, state: RefreshState) {
        stateTitles[state] = title
        stateLabel.text = stateTitles[self.state]
    }

    // MARK: - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
    var currentCalendar: NSCalendar {

//        guard #available(iOS 8.0, *) else {
            return NSCalendar.currentCalendar()
//        }

//         return NSCalendar(identifier: NSCalendarIdentifierGregorian)!


//        if #available(iOS 8.0, *) {
//            return NSCalendar(identifier: NSCalendarIdentifierGregorian)!
//        } else {
//            return NSCalendar.currentCalendar()
//        }
    }
    
    // MARK: - key的处理
    override var lastUpdatedTimeKey: String! {
        get {
            return super.lastUpdatedTimeKey
        }
        set {
            super.lastUpdatedTimeKey = newValue
            
            // 如果label隐藏了，就不用再处理
            if lastUpdatedTimeLabel.hidden {
                return
            }
            
            let lastUpdatedTime = NSUserDefaults.standardUserDefaults().objectForKey(lastUpdatedTimeKey) as? NSDate
            
            // 如果有block
            if lastUpdatedTimeText != nil {
                lastUpdatedTimeLabel.text = lastUpdatedTimeText!(lastUpdatedTime: lastUpdatedTime)
                return
            }
            
            if lastUpdatedTime != nil {
            
                // 1.获得年月日
                let calendar = currentCalendar
                let unitFlags: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute]
                let cmp1 = calendar.components(unitFlags, fromDate: lastUpdatedTime!)
                
                let cmp2 = calendar.components(unitFlags, fromDate: NSDate())
                
                // 2.格式化日期
                let formatter = NSDateFormatter()
                if cmp1.day == cmp2.day { // 今天
                    formatter.dateFormat = "今天 HH:mm"
                } else if cmp1.year == cmp2.year { // 今年
                    formatter.dateFormat = "MM-dd HH:mm"
                } else {
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                }
                let time = formatter.stringFromDate(lastUpdatedTime!)
                
                // 3.显示日期
                lastUpdatedTimeLabel.text = "最后更新：\(time)"
            } else {
                lastUpdatedTimeLabel.text = "最后更新：无记录"
            }
        }
    }
    
    // MARK: - 覆盖父类的方法
    override func prepare() {
        lastUpdatedTimeLabel = UILabel.genLabel()
        stateLabel = UILabel.genLabel()
        addSubview(lastUpdatedTimeLabel)
        addSubview(stateLabel)
        
        super.prepare()
        
        // 初始化文字
        setTitle(RefreshHeaderIdleText, state: RefreshState.Idle)
        setTitle(RefreshHeaderPullingText, state: RefreshState.Pulling)
        setTitle(RefreshHeaderRefreshingText, state: RefreshState.Refreshing)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        if stateLabel.hidden {
            return
        }
        
        let noConstrainsOnStatusLabel = stateLabel.constraints.count == 0
        
        if lastUpdatedTimeLabel.hidden {
            // 状态
            if (noConstrainsOnStatusLabel) {
                stateLabel.frame = bounds
            }
            
        } else {
            let stateLabelH = height * 0.5
            // 状态
            if (noConstrainsOnStatusLabel) {
                stateLabel.x = 0
                stateLabel.y = 0
                stateLabel.width = width
                stateLabel.height = stateLabelH
            }
            
            // 更新时间
            if lastUpdatedTimeLabel.constraints.count == 0 {
                lastUpdatedTimeLabel.x = 0
                lastUpdatedTimeLabel.y = stateLabelH
                lastUpdatedTimeLabel.width = width
                lastUpdatedTimeLabel.height = height - lastUpdatedTimeLabel.y
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
            
            // 设置状态文字
            stateLabel.text = stateTitles[state]
            
            // 重新设置key（重新显示时间）
            let tmp = lastUpdatedTimeKey
            lastUpdatedTimeKey = tmp
        }
    }
    
}
