//
//  RefreshBackNormalFooter.swift
//  STRefreshDemo
//
//  Created by 沈兆良 on 16/4/26.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import UIKit

class RefreshBackNormalFooter: RefreshBackStateFooter {

    var arrowView: UIImageView!
    var loadingView: UIActivityIndicatorView!
    /** 菊花的样式 */
    var activityIndicatorViewStyle: UIActivityIndicatorViewStyle! {
        didSet {
            loadingView?.removeFromSuperview()
            
            loadingView = UIActivityIndicatorView(activityIndicatorStyle: activityIndicatorViewStyle)
            loadingView.hidesWhenStopped = true
            
            addSubview(loadingView)
            
            setNeedsLayout()
        }
    }
    
    // MARK: - 重写父类的方法
    override func prepare() {
        super.prepare()
        
        activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        let image = UIImage(named: "arrow.png")
        arrowView = UIImageView(image: image)
        
        addSubview(arrowView)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        
        // 箭头的中心点
        var arrowCenterX = width * 0.5
        if !stateLabel.hidden {
            arrowCenterX -= 100
        }
        let arrowCenterY = height * 0.5
        let arrowCenter = CGPointMake(arrowCenterX, arrowCenterY)
        
        // 箭头
        if arrowView.constraints.count == 0 {
            arrowView.size = arrowView.image!.size
            arrowView.center = arrowCenter
        }
        
        // 圈圈
        if loadingView.constraints.count == 0 {
            loadingView.center = arrowCenter
        }
    }
    
    override var state: RefreshState {
        get {
            return super.state
        }
        set {
            if newValue == state {
                return
            }
            let oldValue = state
            super.state = newValue
            
            // 根据状态做事情
            if state == .Idle {
                if oldValue == .Refreshing {
                    arrowView.transform = CGAffineTransformMakeRotation(CGFloat(0.000001 - M_PI))
                    
                    UIView.animateWithDuration(RefreshSlowAnimationDuration,
                        animations: {
                            self.loadingView.alpha = 0.0
                            
                        },
                        completion: { result in
                            self.loadingView.alpha = 1.0
                            self.loadingView.stopAnimating()
                            
                            self.arrowView.hidden = false
                        }
                    )
                    
                } else {
                    arrowView.hidden = false
                    loadingView.stopAnimating()
                    UIView.animateWithDuration(RefreshFastAnimationDuration) {
                        self.arrowView.transform = CGAffineTransformMakeRotation(CGFloat(0.000001 - M_PI))
                    }

                }
            } else if state == .Pulling {
                arrowView.hidden = false
                loadingView.stopAnimating()
                UIView.animateWithDuration(RefreshFastAnimationDuration) {
                    self.arrowView.transform = CGAffineTransformIdentity
                }

            } else if state == .Refreshing {
                arrowView.hidden = true
                loadingView.startAnimating()
                
            } else if state == .NoMoreData {
                arrowView.hidden = true
                loadingView.stopAnimating()
            }
        }
    }
    
    

}
