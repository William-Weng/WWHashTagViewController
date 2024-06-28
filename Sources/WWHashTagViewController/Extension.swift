//
//  Extension.swift
//  WWHashTagView
//
//  Created by William.Weng on 2024/6/27.
//

import UIKit

// MARK: - UIStoryboard (static function)
extension UIStoryboard {
    
    /// 由UIStoryboard => ViewController
    /// - Parameters:
    ///   - name: Storyboard的名稱 => Main.storyboard
    ///   - storyboardBundleOrNil: Bundle名稱
    ///   - identifier: ViewController的代號 (記得要寫)
    /// - Returns: T (泛型) => UIViewController
    static func _instantiateViewController<T: UIViewController>(name: String = "Main", bundle storyboardBundleOrNil: Bundle? = nil, identifier: String = String(describing: T.self)) -> T {
        
        let viewController = Self(name: name, bundle: storyboardBundleOrNil).instantiateViewController(identifier: identifier) as T
        return viewController
    }
}

// MARK: - UICollectionView (function)
extension UICollectionView {
    
    /// 初始化Protocal
    /// - Parameter this: UICollectionViewDelegate & UICollectionViewDataSource
    func _delegateAndDataSource(with this: UICollectionViewDelegate & UICollectionViewDataSource) {
        self.delegate = this
        self.dataSource = this
    }
    
    /// 清除Protocal
    func _removeDelegateAndDataSource() {
        self.delegate = nil
        self.dataSource = nil
    }
    
    /// 隱藏滾動條
    /// - Parameter isHidden: Bool
    func _hideScrollIndicator(_ isHidden: Bool = true) {
        showsHorizontalScrollIndicator = !isHidden
        showsVerticalScrollIndicator = !isHidden
    }
    
    /// 取得UICollectionViewCell
    /// - let cell = collectionView._reusableCell(at: indexPath) as MyCollectionViewCell
    /// - Parameter indexPath: IndexPath
    /// - Returns: 符合CellReusable的Cell
    func _reusableCell<T: CellReusable>(at indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else { fatalError("UICollectionViewCell Error") }
        return cell
    }
    
    /// 註冊Cell (使用Class)
    /// - Parameter cellClass: 符合CellReusable的Cell
    func _registerCell<T: CellReusable>(with cellClass: T.Type) { register(cellClass.self, forCellWithReuseIdentifier: cellClass.identifier) }
}

extension CALayer {
    
    /// [設定圓角](https://www.appcoda.com.tw/calayer-introduction/)
    /// - [可以個別設定要哪幾個角 / 預設是四個角全是圓角](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/讓-view-變圓角的-layer-cornerradius-54aa7afda2a1)
    /// - Parameters:
    ///   - radius: 圓的半徑
    ///   - masksToBounds: Bool
    ///   - corners: 圓角要哪幾個邊
    func _maskedCorners(radius: CGFloat, masksToBounds: Bool = true, corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        self.masksToBounds = masksToBounds
        self.maskedCorners = corners
        self.cornerRadius = radius
    }
}

