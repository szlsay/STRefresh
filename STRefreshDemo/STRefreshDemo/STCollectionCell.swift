//
//  STCollectionCell.swift
//  Refresh
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年  lifirewolf. All rights reserved.
//

import UIKit

class STCollectionCell: UICollectionViewCell {

    // MARK: - --- interface 接口

    // MARK: - --- lift cycle 生命周期 ---

    class func cellWithCollectionView(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell {
        let stringClass = NSStringFromClass(self).componentsSeparatedByString(".").last
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(stringClass!,
                                                                         forIndexPath: indexPath)
//        var cell = tableView.dequeueReusableCellWithIdentifier(stringClass!)
//        guard (cell != nil) else {
//            cell = super.init(style: .Default, reuseIdentifier: stringClass)
//            return cell!
//        }

        return cell
    }

//    init(frame: CGRect) {
//        super.init(frame: frame)
//    }




    // MARK: - --- delegate 视图委托 ---

    // MARK: - --- event response 事件相应 ---

    // MARK: - --- private methods 私有方法 ---

    // MARK: - --- setters 属性 ---

    // MARK: - --- getters 属性 ---
}
