//
//  TableViewController.swift
//  Refresh
//
//  Created by  lifirewolf on 16/3/3.
//  Copyright © 2016年  lifirewolf. All rights reserved.
//

import UIKit

let duration = 2.0

class TableViewController: UIViewController {

    // MARK: - --- interface 接口

    // MARK: - --- lift cycle 生命周期 ---
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        example02()
    }
    // MARK: - --- delegate 视图委托 ---

    // MARK: - --- event response 事件相应 ---

    // MARK: - --- private methods 私有方法 ---

    // MARK: - --- setters 属性 ---

    // MARK: - --- getters 属性 ---
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()



    var data = [String]()


    func example01() {
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        tableView.refreshHeader = RefreshNormalHeader() {
            self.loadNewData()
        }
        
        // 马上进入刷新状态
        tableView.refreshHeader.beginRefreshing()
    }
    
    func example02() {
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        tableView.refreshHeader = ChiBaoZiHeader() {
            self.loadNewData()
        }
        
        // 马上进入刷新状态
        tableView.refreshHeader.beginRefreshing()
    }
    
    func example03() {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        let header = RefreshNormalHeader() {
            self.loadNewData()
        }
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        header.automaticallyChangeAlpha = true
        
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = true
        
        // 马上进入刷新状态
        header.beginRefreshing()
        
        // 设置header
        tableView.refreshHeader = header
    }
    
    // mark UITableView + 下拉刷新 隐藏状态和时间
    func example04() {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        let header = ChiBaoZiHeader() {
            self.loadNewData()
        }
    
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = true
        
        // 隐藏状态
        header.stateLabel.hidden = true
        
        // 马上进入刷新状态
        header.beginRefreshing()
        
        // 设置header
        tableView.refreshHeader = header
    }
    
    // mark UITableView + 下拉刷新 自定义文字
    func example05() {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        let header = RefreshNormalHeader() {
            self.loadNewData()
        }
        
        // 设置文字
        header.setTitle("Pull down to refresh", state: .Idle)
        header.setTitle("Release to refresh", state: .Pulling)
        header.setTitle("Loading ...", state: .Refreshing)
        
        // 设置字体
        header.stateLabel.font = UIFont.systemFontOfSize(15)
        header.lastUpdatedTimeLabel.font = UIFont.systemFontOfSize(14)
        
        // 设置颜色
        header.stateLabel.textColor = UIColor.redColor()
        header.lastUpdatedTimeLabel.textColor = UIColor.blueColor()
        
        // 马上进入刷新状态
        header.beginRefreshing()
        
        // 设置刷新控件
        tableView.refreshHeader = header
    }
    
    // mark UITableView + 下拉刷新 自定义刷新控件
    func example06() {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        tableView.refreshHeader = DIYHeader() {
            self.loadNewData()
        }
        tableView.refreshHeader.beginRefreshing()
    }
    
    // mark UITableView + 上拉刷新 默认
    func example11() {
        example01()
        
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        tableView.refreshFooter = RefreshAutoNormalFooter() {
            self.loadMoreData()
        }
    }
    
    // mark UITableView + 上拉刷新 动画图片
    func example12() {
    
        example01()
    
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        tableView.refreshFooter = ChiBaoZiFooter() {
            self.loadMoreData()
        }
    }
    
    // mark UITableView + 上拉刷新 隐藏刷新状态的文字
    func example13() {
        example01()
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        let footer = ChiBaoZiFooter() {
            self.loadMoreData()
        }
        
        // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
        //    footer.triggerAutomaticallyRefreshPercent = 0.5;
        
        // 隐藏刷新状态的文字
        footer.refreshingTitleHidden = true
        
        // 设置footer
        tableView.refreshFooter = footer
    }
    
    // mark UITableView + 上拉刷新 全部加载完毕
    func example14() {
    
        example01()
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
        tableView.refreshFooter = RefreshAutoNormalFooter() {
            self.loadLastData()
        }
        
        // 其他
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "恢复数据加载", style: UIBarButtonItemStyle.Done, target: self, action: #selector(reset))
    }
    
    func reset() {
        //    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        //    [self.tableView.mj_footer beginRefreshing];
        tableView.refreshFooter.resetNoMoreData()
    }
    
    // mark UITableView + 上拉刷新 禁止自动加载
    func example15() {
        
        example01()
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        let footer = RefreshAutoNormalFooter() {
            self.loadMoreData()
        }
        
        // 禁止自动加载
        footer.automaticallyRefresh = false
        
        // 设置footer
        tableView.refreshFooter = footer
    }
    
    // mark UITableView + 上拉刷新 自定义文字
    func example16() {
        example01()
        
        // 添加默认的上拉刷新
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        let footer = RefreshAutoNormalFooter() {
            self.loadMoreData()
        }
        
        // 设置文字
        footer.setTitle("Click or drag up to refresh", state: .Idle)
        footer.setTitle("Loading more ...", state: .Refreshing)
        footer.setTitle("No more data", state: .NoMoreData)
        
        // 设置字体
        footer.stateLabel.font = UIFont.systemFontOfSize(17)
        
        // 设置颜色
        footer.stateLabel.textColor = UIColor.blueColor()
        
        // 设置footer
        tableView.refreshFooter = footer
    }
    
    // mark UITableView + 上拉刷新 加载后隐藏
    func example17() {
        
        example01()
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOnceData方法）
        tableView.refreshFooter = RefreshAutoNormalFooter() {
            self.loadOnceData()
        }
    }
    
    // mark UITableView + 上拉刷新 自动回弹的上拉01
    func example18() {
    
        example01()
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        tableView.refreshFooter = RefreshBackNormalFooter() {
            self.loadMoreData()
        }
        
        // 设置了底部inset
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0)
        // 忽略掉底部inset
        tableView.refreshFooter.ignoredScrollViewContentInsetBottom = 30
    }
    
    // mark UITableView + 上拉刷新 自动回弹的上拉02
    func example19() {
    
        example01()
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
        tableView.refreshFooter = ChiBaoZiFooter2() {
            self.loadLastData()
        }
        
        tableView.refreshFooter.automaticallyChangeAlpha = true
    }
    
    // mark UITableView + 上拉刷新 自定义刷新控件(自动刷新)
    func example20() {
        
        example01()
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        tableView.refreshFooter = DIYAutoFooter() {
            self.loadMoreData()
        }
    }
    
    // mark UITableView + 上拉刷新 自定义刷新控件(自动回弹)
    func example21() {
        
        example01()
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        tableView.refreshFooter = DIYBackFooter() {
            self.loadMoreData()
        }
    }
    
    func randomData() -> String {
        return "随机数据---\(arc4random_uniform(1000000))"
    }
    
    func loadNewData() {
        // 1.添加假数据
        for _ in 0..<5 {
            data.insert(randomData(), atIndex: 0)
        }
        
        // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            // 刷新表格
            self.tableView.reloadData()
            
            // 拿到当前的下拉刷新控件，结束刷新状态
            self.tableView.refreshHeader.endRefreshing()
        }
    }
    
    // mark 上拉加载更多数据
    func loadMoreData() {
        // 1.添加假数据
        for _ in 0..<5 {
            data.append(randomData())
        }
        
        // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            // 刷新表格
            self.tableView.reloadData()
            
            // 拿到当前的上拉刷新控件，结束刷新状态
            self.tableView.refreshFooter.endRefreshing()
        }
    }
    
    func loadLastData() {
        // 1.添加假数据
        for _ in 0..<5 {
            data.append(randomData())
        }
        
        // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            // 刷新表格
            self.tableView.reloadData()
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            self.tableView.refreshFooter.endRefreshingWithNoMoreData()
        }
    }
    
    // mark 只加载一次数据
    func loadOnceData() {
        // 1.添加假数据
        for _ in 0..<5 {
            data.append(randomData())
        }
        
        // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            // 刷新表格
            self.tableView.reloadData()
            
            // 隐藏当前的上拉刷新控件
            self.tableView.refreshFooter.hidden = true
        }
    }
}

extension TableViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = STTableCell.cellWithTableView(tableView)
        cell.textLabel!.text = data[indexPath.row]
        return cell
    }
}

extension TableViewController: UITableViewDelegate{

}
