//
//  WWHashTagViewController.swift
//  WWHashTagView
//
//  Created by William.Weng on 2024/6/27.
//

import UIKit

// MARK: - WWHashTagViewController
open class WWHashTagViewController: UIViewController {
    
    public typealias ColorInformation = (selected: UIColor, unselected: UIColor)    // (點到的顏色, 沒點到的顏色)
    
    /// Layout類型
    public enum CollectionViewLayoutType {
        case `default`(type: ScrollDirectionType, itemHeight: CGFloat, minimumLineSpacing: CGFloat)
        case custom(layout: UICollectionViewLayout)
    }
    
    /// 滾動類型
    public enum ScrollDirectionType {
        case horizontal(count: CGFloat)
        case vertical(count: UInt)
    }

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    public weak var delegate: WWHashTagViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
        
    deinit {
        deinitAction()
    }
}

// MARK: - 開放函式
public extension WWHashTagViewController {
    
    /// 建立WWHashTagViewController
    /// - Returns: WWHashTagViewController
    static func build() -> WWHashTagViewController {
        return UIStoryboard._instantiateViewController(name: "Package", bundle: .module)
    }
}

// MARK: - 開放函式
public extension WWHashTagViewController {
    
    /// 重新讀取Items
    func reloadData() {
        myCollectionView?.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension WWHashTagViewController: UICollectionViewDataSource {}
public extension WWHashTagViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.number(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellMaker(collectionView, cellForItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension WWHashTagViewController: UICollectionViewDelegate {}
public extension WWHashTagViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSetting(collectionView, didSelectItemAt: indexPath)
    }
}

// MARK: - 小工具
private extension WWHashTagViewController {
    
    /// 初始化設定
    func initSetting() {
        myCollectionView._hideScrollIndicator()
        myCollectionView._delegateAndDataSource(with: self)
        myCollectionView.collectionViewLayout = parseLayoutType()
    }
    
    /// [解析UICollectionViewLayout的樣式](https://likeabossapp.com/2018/11/11/客製-uicollectionviewflowlayout-讓-uicollectionview-靠左對齊/?fbclid=IwAR1m6uQdbswbe3vllzGM--wP3HKKdFPFxBT7S0MgdgYCL65ac77vWT495Rk)
    /// - Returns: UICollectionViewLayout
    func parseLayoutType() -> UICollectionViewLayout {
                
        guard let type = delegate?.layoutType(self) else { return .init() }

        switch type {
        case .default(let type, let itemHeight, let minimumLineSpacing): return defaultLayoutMaker(type: type, itemHeight: itemHeight, minimumLineSpacing: minimumLineSpacing)
        case .custom(let layout): return layout
        }
    }
    
    /// [預設樣式的UICollectionViewFlowLayout](https://itisjoe.gitbooks.io/swiftgo/content/uikit/uicollectionview.html)
    /// - Parameters:
    ///   - type: ScrollDirectionType
    ///   - itemHeight: CGFloat
    ///   - minimumLineSpacing: CGFloat
    /// - Returns: UICollectionViewFlowLayout
    func defaultLayoutMaker(type: ScrollDirectionType, itemHeight: CGFloat, minimumLineSpacing: CGFloat) -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let itemCount: CGFloat
        
        switch type {
        case .horizontal(let count):
            layout.scrollDirection = .horizontal
            itemCount = count
        case .vertical(let count):
            layout.scrollDirection = .vertical
            itemCount = CGFloat(count)
        }
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = minimumLineSpacing
        layout.itemSize = CGSizeMake(CGFloat(view.frame.width) / itemCount - 10.0, itemHeight)
        
        return layout
    }
    
    /// 產生WWHashTagViewControllerCell
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: IndexPath
    /// - Returns: WWHashTagViewControllerCell
    func cellMaker(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> WWHashTagViewControllerCell {
        
        let cell = collectionView._reusableCell(at: indexPath) as WWHashTagViewControllerCell
                
        if let view = delegate?.hashTagViewController(self, viewForItemAt: indexPath) {
            view._autolayout(on: cell)
        }
        
        return cell
    }
    
    /// Cell被點到的動作
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: IndexPath
    func cellSetting(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        defer {
            delegate?.hashTagViewController(self, collectionView: collectionView, didSelectItemAt: indexPath)
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? WWHashTagViewControllerCell else { return }
        cell.configure(with: indexPath)
    }
        
    /// deinit後要做的事
    func deinitAction() {
        myCollectionView._removeDelegateAndDataSource()
    }
}


