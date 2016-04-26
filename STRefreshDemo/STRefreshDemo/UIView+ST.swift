//
//  UIView+ST.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/11.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {

    /// 1.上
    public var top : CGFloat {
        get {
            return CGRectGetMinY(self.frame)
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    /// 2.下
    public var bottom : CGFloat {
        get {
            return CGRectGetMaxY(self.frame)
        }
        set {
            self.frame.origin.y = newValue - self.frame.size.height
        }
    }

    /// 3.左
    public var left : CGFloat {
        get {
            return CGRectGetMinX(self.frame)
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    /// 4.右
    public var right : CGFloat {
        get {
            return CGRectGetMaxX(self.frame)
        }
        set {
            self.frame.origin.x = newValue - self.frame.size.width
        }
    }

    /// 5.x
    public var x : CGFloat {
        get {
            return CGRectGetMinX(self.frame)
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    /// 6.y
    public var y : CGFloat {
        get {
            return CGRectGetMinY(self.frame)
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    /// 7.width
    public var width : CGFloat {
        get {
            return CGRectGetWidth(self.frame)
        }
        set {
            self.frame.size.width = newValue
        }
    }

    /// 8.height
    public var height : CGFloat {
        get {
            return CGRectGetHeight(self.frame)
        }
        set {
            self.frame.size.height = newValue
        }
    }

    /// 9.中心点X值
    public var centerX : CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }

    /// 10.中心点Y值
    public var centerY : CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }

    public var size : CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
}