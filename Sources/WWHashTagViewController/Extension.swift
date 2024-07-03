//
//  Extension.swift
//  WWHashTagView
//
//  Created by William.Weng on 2024/6/27.
//

import UIKit

// MARK: - Collection (function)
extension Collection where Self.Element: UIView {
        
    /// 將所有View移除
    func _removeFromSuperview() {
        self.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - UIView (function)
extension UIView {
    
    /// [設定LayoutConstraint => 不能加frame](https://zonble.gitbooks.io/kkbox-ios-dev/content/autolayout/intrinsic_content_size.html)
    /// - Parameter view: [要設定的View](https://www.appcoda.com.tw/auto-layout-programmatically/)
    func _autolayout(on view: UIView) {

        removeFromSuperview()
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

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
