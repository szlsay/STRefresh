//
//  UIScrollView+Refresh.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

extension NSObject {
    
    static func exchangeInstanceMethod1(method1: Selector, method2: Selector) {
        method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2))
    }
    
    static func exchangeClassMethod1(method1: Selector, method2: Selector) {
        method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2))
    }
}

extension UIScrollView {
    
    private struct AssociatedKeys {
        static var RefreshHeaderKey = "RefreshHeaderKey"
        static var RefreshFooterKey = "RefreshFooterKey"
        static var ReloadDataBlockKey = "ReloadDataBlockKey"
    }
    
    var refreshHeader: RefreshHeader! {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.RefreshHeaderKey) as? RefreshHeader
        }
        set {
            if refreshHeader != newValue {
                // 删除旧的，添加新的
                refreshHeader?.removeFromSuperview()
                
                if let newValue = newValue {
                    insertSubview(newValue, atIndex: 0)
                    
                    // 存储新的
                    willChangeValueForKey("refreshHeader")
                    objc_setAssociatedObject(self, &AssociatedKeys.RefreshHeaderKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
                    didChangeValueForKey("refreshHeader")
                }
            }
        }
    }
    
    var refreshFooter: RefreshFooter! {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.RefreshFooterKey) as? RefreshFooter
        }
        set {
            if refreshFooter != newValue {
                // 删除旧的，添加新的
                refreshFooter?.removeFromSuperview()
                
                if let newValue = newValue {
                    addSubview(newValue)
                    
                    // 存储新的
                    willChangeValueForKey("refreshFooter")
                    objc_setAssociatedObject(self, &AssociatedKeys.RefreshFooterKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
                    didChangeValueForKey("refreshFooter")
                }
            }
        }
    }
    
    var totalDataCount: Int {
        var totalCount = 0
        if let tableView = self as? UITableView {
            
            for i in 0 ..< tableView.numberOfSections {
                totalCount += tableView.numberOfRowsInSection(i)
            }

        } else if let collectionView = self as? UICollectionView {
            
            for i in 0 ..< collectionView.numberOfSections() {
                
                totalCount += collectionView.numberOfItemsInSection(i)
            }

        }
        return totalCount
    }
    
    var reloadDataBlock: ((Int) -> Void)? {
        get {
            let wrapper = objc_getAssociatedObject(self, &AssociatedKeys.ReloadDataBlockKey) as? ClosureWrapper
            return wrapper?.closure
        }
        set {
            if let newValue = newValue {
                let wrapper = ClosureWrapper(newValue)
                willChangeValueForKey("reloadDataBlock")
                objc_setAssociatedObject(self, &AssociatedKeys.ReloadDataBlockKey, wrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                didChangeValueForKey("reloadDataBlock")
            }
        }
    }
    
    func executeReloadDataBlock() {
        if let reloadDataBlock = reloadDataBlock {
            reloadDataBlock(totalDataCount)
        }
    }
    
}

private class ClosureWrapper {
    var closure: ((Int) -> Void)?
    
    init(_ closure: ((Int) -> Void)?) {
        self.closure = closure
    }
}

extension UITableView {
    override public class func initialize () {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        // make sure this isn't a subclass
        if self !== UITableView.self {
            return
        }
        
        dispatch_once(&Static.token) {
            self.exchangeInstanceMethod1(#selector(UITableView.reloadData), method2: #selector(UITableView.refresherReloadData))
        }
    }
    
    func refresherReloadData() {
        refresherReloadData()
        executeReloadDataBlock()
    }
}

extension UICollectionView {
    override public class func initialize () {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        // make sure this isn't a subclass
        if self !== UICollectionView.self {
            return
        }
        
        dispatch_once(&Static.token) {
            self.exchangeInstanceMethod1(#selector(UITableView.reloadData), method2: #selector(UITableView.refresherReloadData))
        }
    }
    
    func refresherReloadData() {
        self.refresherReloadData()
        executeReloadDataBlock()
    }
}
