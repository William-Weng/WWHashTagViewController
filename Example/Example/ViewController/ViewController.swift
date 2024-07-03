//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/1/1.
//

import UIKit
import WWHashTagViewController

// MARK: - ViewController
final class ViewController: UIViewController {

    @IBOutlet weak var myContainerView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var myLabel: UILabel!
    
    private let height = 125.0
    
    private var isOn = false
    private var count = 0
    private var productName = "iPhone"
    private var selectedItems: Set<IndexPath> = []
    private var hashTagViewController: WWHashTagViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        refreshAction()
    }
        
    @IBAction func changeConstraint(_ sender: UIBarButtonItem) {
        changeConstraintAction()
    }
}

// MARK: - WWHashTagViewControllerDelegate
extension ViewController: WWHashTagViewControllerDelegate {
    
    func number(_ hashTagViewController: WWHashTagViewController) -> Int {
        return count
    }
    
    func layoutType(_ hashTagViewController: WWHashTagViewController) -> WWHashTagViewController.CollectionViewLayoutType {
        return .default(type: .vertical(count: 3), itemHeight: 56, minimumLineSpacing: 5)
    }
    
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, viewForItemAt indexPath: IndexPath) -> UIView {
        
        let cellView = CellView(frame: .zero)
        cellViewSetting(cellView, indexPath: indexPath)
        
        return cellView
    }
    
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? WWHashTagViewControllerCell,
              let cellView = cell.subviews.last as? CellView
        else {
            return
        }
        
        cellViewAction(cellView, indexPath: indexPath)
    }
}

// MARK: - 小工具
private extension ViewController {
    
    /// 初始化設定
    func initSetting() {
        
        heightConstraint.constant = 0
        count = 3
        
        hashTagViewController = WWHashTagViewController.build()
        hashTagViewController.delegate = self
        hashTagViewController._transparent()
        
        myContainerView._changeViewController(parent: self, to: hashTagViewController)
    }
    
    /// 更新資料
    func refreshAction() {
        productName = (productName == "iPhone") ? "iPad" : "iPhone"
        count = count * 2
        hashTagViewController.reloadData()
    }
    
    /// 改變高度 (動畫)
    func changeConstraintAction() {
        
        defer {
            
            if (isOn) { self.hashTagViewController.reloadData() }
            
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                if (!self.isOn) { self.hashTagViewController.reloadData() }
            }
        }
        
        isOn.toggle()
        if (!isOn) { count = 0; heightConstraint.constant = 0; selectedItems = []; return }
        
        count = 5
        heightConstraint.constant = height
    }
    
    /// 產生自定義View的時候使用
    /// - Parameters:
    ///   - cellView: CellView
    ///   - indexPath: IndexPath
    func cellViewSetting(_ cellView: CellView, indexPath: IndexPath) {
        
        cellView.myLabel.text = "\(indexPath.row)"
        
        if (selectedItems.contains(indexPath)) {
            cellView.contentView.backgroundColor = .red
            cellView.myLabel.textColor = .white
        } else {
            cellView.contentView.backgroundColor = .systemGray3
            cellView.myLabel.textColor = .black
        }
    }
    
    /// 改變自定義畫面相關設定
    /// - Parameters:
    ///   - cellView: CellView
    ///   - indexPath: IndexPath
    func cellViewAction(_ cellView: CellView, indexPath: IndexPath) {
        
        cellView.myLabel.text = "\(indexPath.row)"
        
        if (!selectedItems.contains(indexPath)) {
            selectedItems.insert(indexPath)
            cellView.contentView.backgroundColor = .red
            cellView.myLabel.textColor = .white
        } else {
            selectedItems.remove(indexPath)
            cellView.contentView.backgroundColor = .systemGray3
            cellView.myLabel.textColor = .black
        }
    }
}
