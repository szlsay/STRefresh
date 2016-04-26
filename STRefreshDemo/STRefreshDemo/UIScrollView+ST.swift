//
//  UIScrollView+ST.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/11.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import Foundation
import UIKit

public extension UIScrollView {

    /// 1.上方的

    public var insetTop : CGFloat {
        get {
            return contentInset.top
        }
        set {
            contentInset.top = newValue
        }
    }

    /// 2.左边的
    public var insetLeft : CGFloat {
        get {
            return contentInset.left
        }
        set {
            contentInset.left = newValue
        }
    }

    /// 3.下方的
    public var insetBottom : CGFloat {
        get {
            return contentInset.bottom
        }
        set {
            contentInset.bottom = newValue
        }
    }

    /// 4.右边的
    public var insetRight : CGFloat {
        get {
            return contentInset.right
        }
        set {
            contentInset.right = newValue
        }
    }

    /// 5.偏移X值
    public var offsetX : CGFloat {
        get {
            return contentOffset.x
        }
        set {
            contentOffset.x = newValue
        }
    }

    /// 6.偏移Y值
    public var offsetY : CGFloat {
        get {
            return contentOffset.y
        }
        set {
            contentOffset.y = newValue
        }
    }

    /// 7.内部宽度
    public var contentWidth : CGFloat {
        get {
            return contentSize.width
        }
        set {
            contentSize.width = newValue
        }
    }

    /// 8.内部高度
    public var contentHeight : CGFloat {
        get {
            return contentSize.height
        }
        set {
            contentSize.height = newValue
        }
    }
}
