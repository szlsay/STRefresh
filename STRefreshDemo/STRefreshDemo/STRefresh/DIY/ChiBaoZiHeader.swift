//
//  ChiBaoZiHeader.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class ChiBaoZiHeader: RefreshGifHeader {

    // MARK: 基本设置
    override func prepare() {
        super.prepare()
        
        // 设置普通状态的动画图片
        var idleImages = [UIImage]()
        for i in 1...60 {
            let image = UIImage(named: "dropdown_anim__000\(i)")!
            
            idleImages.append(image)
        }
        setImages(idleImages, state: RefreshState.Idle)
        
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        var refreshingImages = [UIImage]()
        for i in 1...3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")!
            
            refreshingImages.append(image)
        }
        setImages(refreshingImages, state: RefreshState.Pulling)
        
        // 设置正在刷新状态的动画图片
        setImages(refreshingImages, state: RefreshState.Refreshing)
    }
    
}
