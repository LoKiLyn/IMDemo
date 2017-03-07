//
//  ScrollView+PullToRefresh.swift
//  Luka
//
//  Created by 宋鹏程 on 2017/2/10.
//  Copyright © 2017年 北京物灵智能科技有限公司. All rights reserved.
//

import Foundation
import MJRefresh


// MARK: - Public

public enum ScrollDirection {
    case refresh
    case loadMore
}

extension UIScrollView {
    
    // MARK: - PullToRefresh
    
    public var refreshClosure: () -> Swift.Void {
        get {
            return self.refreshClosure
        }
        set {
            let header = MJRefreshNormalHeader(refreshingBlock: newValue)
            header?.lastUpdatedTimeLabel.isHidden = true
            self.mj_header = header
            
            if let footer = self.mj_footer {
                footer.isHidden = true
            }
        }
    }
    
    public func beginRefreshing() {
        self.mj_header.beginRefreshing()
    }
    
    public func endRefreshing() {
        self.mj_header.endRefreshing()
    }
    
    
    // MARK: - LoadMore
    
    public var loadMoreClosure: () -> Swift.Void {
        get {
            return self.loadMoreClosure
        }
        set {
            let footer = MJRefreshAutoNormalFooter(refreshingBlock: newValue)
            footer?.isHidden = true
            self.mj_footer = footer
        }
    }
    
    public func beginLoadMore() {
        self.mj_footer.beginRefreshing()
    }
    
    public func endLoadMore() {
        self.mj_footer.endRefreshing()
    }
    
    var hasMore: Bool {
        get {
            return self.hasMore
        }
        set {
            self.mj_footer.isHidden = false
            if newValue {
                self.mj_footer.resetNoMoreData()
            } else {
                self.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
    
}
