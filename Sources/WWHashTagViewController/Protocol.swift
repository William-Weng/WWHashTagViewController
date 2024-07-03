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
    
    /// Layout的方式 (預設 / 自訂)
    func layoutType(_ hashTagViewController: WWHashTagViewController) -> WWHashTagViewController.CollectionViewLayoutType
    
    /// 產生要加上Cell上的自訂View
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, viewForItemAt indexPath: IndexPath) -> UIView
    
    /// 被點到時的反應
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

// MARK: - 可重複使用的Cell (UITableViewCell / UICollectionViewCell)
protocol CellReusable: AnyObject {
    
    static var identifier: String { get }
    var indexPath: IndexPath { get }
    
    /// Cell的相關設定
    /// - Parameters:
    ///   - indexPath: IndexPath
    func configure(with indexPath: IndexPath)
}

// MARK: - 預設 identifier = class name (初值)
extension CellReusable {
    static var identifier: String { return String(describing: Self.self) }
}
