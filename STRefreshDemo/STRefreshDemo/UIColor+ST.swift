//
//  UIColor+ST.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/11.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import Foundation
import UIKit

public func RGBA(r: Int, g: Int, b: Int, a: Float) -> UIColor {
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
}

public func RGB(r:Int, g:Int, b:Int) -> UIColor {
    return RGBA(r, g: g, b: b, a: 1)
}

public extension UIColor {

    public static func colorRandom() -> UIColor
    {
        let r: UInt32 = arc4random_uniform(255)
        let g: UInt32 = arc4random_uniform(255)
        let b: UInt32 = arc4random_uniform(255)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}

