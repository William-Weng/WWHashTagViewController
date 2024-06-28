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
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let cellColor: WWHashTagViewController.ColorInformation = (selected: .red, unselected: .lightGray)
    static let textColor: WWHashTagViewController.ColorInformation = (selected: .white, unselected: .black)
    
    static var titles: [String?]? = []
    static var selectedItems: Set<IndexPath> = []
    
    /// 相關設定
    /// - Parameters:
    ///   - indexPath: IndexPath
    ///   - title: String?
    ///   - font: UIFont
    func configure(with indexPath: IndexPath, title: String?, font: UIFont?) {
        
        self.indexPath = indexPath
        
        titleView.layoutIfNeeded()
        titleView.layer._maskedCorners(radius: titleView.frame.height * 0.5)
        titleLabel.text = title
        
        if let font = font { titleLabel.font = font }
        
        if (Self.selectedItems.contains(indexPath)) {
            titleView.backgroundColor = Self.cellColor.selected
            titleLabel.textColor = Self.textColor.selected
        } else {
            titleView.backgroundColor = Self.cellColor.unselected
            titleLabel.textColor = Self.textColor.unselected
        }
    }
}
