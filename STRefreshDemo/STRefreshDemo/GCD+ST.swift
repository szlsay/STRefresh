//
//  GCD+ST.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/12.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import Foundation

public func delay(delay:Double, closure:()->()) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))),
        dispatch_get_main_queue(), closure)
}

@available(iOS 8.0, *)
public struct GCDST {
    /// 1.主队列
    static func mainQueue() -> dispatch_queue_t {return dispatch_get_main_queue()}

    /// 2.交互队列
    static func userInteractiveQueue() -> dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
    }

    /// 3.已启动队列
    static func userInitiatedQueue() -> dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
    }

    /// 4.有效队列
    static func utilityQueue() -> dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
    }

    /// 5.后台队列
    static func backgroundQueue() -> dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
    }

}

//dispatch_sync(dispatch_get_global_queue(
//    Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)) {
//
//        NSLog("First Log")
//
//}
//
//NSLog("Second Log")
//
//dispatch_async(dispatch_get_global_queue(
//    Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)) {
//
//        NSLog("01 Log")
//
//}
//
//NSLog("02 Log")