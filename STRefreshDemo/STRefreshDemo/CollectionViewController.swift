//
//  CollectionViewController.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/12.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    // MARK: - --- interface 接口
    private let cellIdentifier = "STCollectionCell"

    var colors = [UIColor]()
    // MARK: - --- lift cycle 生命周期 ---

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)

        // 下拉刷新
        collectionView.refreshHeader = RefreshNormalHeader {
            // 增加5条假数据
            for _ in 0..<10 {
                self.colors.insert(UIColor.colorRandom(), atIndex: 0)
            }

            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
          delay(2) {
                self.collectionView.reloadData()

                // 结束刷新
                self.collectionView.refreshHeader.endRefreshing()
            }
        }

        collectionView.refreshHeader.beginRefreshing()

        // 上拉刷新
        collectionView.refreshFooter = RefreshAutoNormalFooter() {
            // 增加5条假数据
            for _ in 0..<10 {
                self.colors.append(UIColor.colorRandom())
            }

            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
           delay(2) {
                self.collectionView.reloadData()

                // 结束刷新
                self.collectionView.refreshFooter.endRefreshing()
            }
        }

        // 默认先隐藏footer
        collectionView.refreshFooter.hidden = true
    }

    // MARK: - --- delegate 视图委托 ---

    // MARK: - --- event response 事件相应 ---

    // MARK: - --- private methods 私有方法 ---

    // MARK: - --- setters 属性 ---

    // MARK: - --- getters 属性 ---
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds,  collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        return collectionView
    }()

    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(80, 80)
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        return layout
    }()



}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 设置尾部控件的显示和隐藏
        collectionView.refreshFooter.hidden = colors.count == 0
        
        return colors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = colors[indexPath.row]

        return cell
    }
}

