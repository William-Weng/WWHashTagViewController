//
//  WWHashTagViewControllerCell.swift
//  WWHashTagView
//
//  Created by William.Weng on 2024/6/27.
//

import UIKit

// MARK: - WWHashTagViewControllerCell
public class WWHashTagViewControllerCell: UICollectionViewCell, CellReusable {
        
    var indexPath: IndexPath = []
    
    public override func prepareForReuse() { self.subviews._removeFromSuperview() }
    
    /// 相關設定
    /// - Parameters:
    ///   - indexPath: IndexPath
    ///   - settings: Settings
    func configure(with indexPath: IndexPath) {
        self.indexPath = indexPath
    }
}
