//
//  Protocol.swift
//  WWHashTagView
//
//  Created by William.Weng on 2024/6/27.
//

import UIKit

// MARK: - WWHashTagViewControllerDelegate
public protocol WWHashTagViewControllerDelegate: AnyObject {
    
    /// Item的數量
    func number(_ hashTagViewController: WWHashTagViewController) -> Int
    
    /// 顯示的標題
    func title(_ hashTagViewController: WWHashTagViewController, with indexPath: IndexPath) -> String?

    /// 標題字型
    func font(_ hashTagViewController: WWHashTagViewController, with indexPath: IndexPath) -> UIFont
    
    /// Layout的方式 (預設 / 自訂)
    func layoutType(_ hashTagViewController: WWHashTagViewController) -> WWHashTagViewController.CollectionViewLayoutType
    
    /// Item背景色
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, didSelectItemBackgroundColorAt indexPath: IndexPath) -> WWHashTagViewController.ColorInformation
    
    /// 文字顏色
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, didSelectItemTextColorAt indexPath: IndexPath) -> WWHashTagViewController.ColorInformation
    
    /// 被點到時的反應
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, didSelectItemAt indexPath: IndexPath, forItems items: Set<IndexPath>)
}

// MARK: - 可重複使用的Cell (UITableViewCell / UICollectionViewCell)
protocol CellReusable: AnyObject {
    
    static var identifier: String { get }
    var indexPath: IndexPath { get }
    
    /// Cell的相關設定
    /// - Parameters:
    ///   - indexPath: IndexPath
    ///   - settings: WWHashTagViewControllerCell.Settings
    func configure(with indexPath: IndexPath, settings: WWHashTagViewControllerCell.Settings)
}

// MARK: - 預設 identifier = class name (初值)
extension CellReusable {
    static var identifier: String { return String(describing: Self.self) }
}
