//
//  ChiBaoZiFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class ChiBaoZiFooter: RefreshAutoGifFooter {

    // MARK: 基本设置
    override func prepare() {
        super.prepare()
        
        // 设置正在刷新状态的动画图片
        var refreshingImages = [UIImage]()
        for i in 1...3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")!
            
            refreshingImages.append(image)
        }
        
        setImages(refreshingImages, state: RefreshState.Refreshing)
    }
}
