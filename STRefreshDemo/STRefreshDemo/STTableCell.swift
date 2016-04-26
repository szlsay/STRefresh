//
//  STCell.swift
//  Refresh
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年  lifirewolf. All rights reserved.
//

import UIKit

class STTableCell: UITableViewCell {

    // MARK: - --- interface 接口

    // MARK: - --- lift cycle 生命周期 ---
    class func cellWithTableView(tableView: UITableView) -> UITableViewCell {
        let stringClass = NSStringFromClass(self).componentsSeparatedByString(".").last
        var cell = tableView.dequeueReusableCellWithIdentifier(stringClass!)
        guard (cell != nil) else {
            cell = super.init(style: .Default, reuseIdentifier: stringClass)
            return cell!
        }
        return cell!
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {

    }
    // MARK: - --- delegate 视图委托 ---

    // MARK: - --- event response 事件相应 ---

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - --- private methods 私有方法 ---

    // MARK: - --- setters 属性 ---

    // MARK: - --- getters 属性 ---
}
