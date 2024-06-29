//
//  WWHashTagViewControllerCell.swift
//  WWHashTagView
//
//  Created by William.Weng on 2024/6/27.
//

import UIKit

// MARK: - WWHashTagViewControllerCell
public class WWHashTagViewControllerCell: UICollectionViewCell, CellReusable {
    
    typealias Settings = (title: String?, font: UIFont?, textColor: WWHashTagViewController.ColorInformation?, backgroundColor: WWHashTagViewController.ColorInformation?)
    
    var indexPath: IndexPath = []
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let defaultBackgroundColor: WWHashTagViewController.ColorInformation = (selected: .red, unselected: .lightGray)
    static let defaultTextColor: WWHashTagViewController.ColorInformation = (selected: .white, unselected: .black)
    
    static var titles: [String?]? = []
    static var selectedItems: Set<IndexPath> = []
    
    /// 相關設定
    /// - Parameters:
    ///   - indexPath: IndexPath
    ///   - settings: Settings
    func configure(with indexPath: IndexPath, settings: Settings) {

        self.indexPath = indexPath
        
        titleView.layoutIfNeeded()
        titleView.layer._maskedCorners(radius: titleView.frame.height * 0.5)
        titleLabel.text = settings.title
        
        if let font = settings.font { titleLabel.font = font }
        
        if (Self.selectedItems.contains(indexPath)) {
            titleView.backgroundColor = settings.backgroundColor?.selected ?? Self.defaultBackgroundColor.selected
            titleLabel.textColor = settings.textColor?.selected ?? Self.defaultTextColor.selected
        } else {
            titleView.backgroundColor = settings.backgroundColor?.unselected ?? Self.defaultBackgroundColor.unselected
            titleLabel.textColor = settings.textColor?.unselected ?? Self.defaultTextColor.unselected
        }
    }
}
