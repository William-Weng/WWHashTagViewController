//
//  Extension.swift
//  Example
//
//  Created by William.Weng on 2024/6/28.
//

import UIKit

// MARK: - CALayer
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

// MARK: - UIView
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
    
    /// [改變ContainerView上的ViewController](https://disp.cc/b/11-9XMd)
    /// - Parameters:
    ///   - parentViewController: 主要的ViewController
    ///   - oldViewController: 舊的ViewController
    ///   - newViewController: 新的ViewController
    func _changeViewController(parent parentViewController: UIViewController, from oldViewController: UIViewController? = nil, to newViewController: UIViewController) {
        
        oldViewController?.willMove(toParent: parentViewController)
        oldViewController?.view.removeFromSuperview()
        oldViewController?.removeFromParent()
        
        parentViewController.addChild(newViewController)
        newViewController.view._autolayout(on: self)
        newViewController.didMove(toParent: parentViewController)
    }
}

// MARK: - UIViewController
extension UIViewController {
    
    /// [改變ContainerView](https://disp.cc/b/11-9XMd)
    /// - Parameters:
    ///   - containerView: UIView
    ///   - oldViewController: 舊的ViewController
    ///   - newViewController: 新的ViewController
    func _changeContainerView(at containerView: UIView, from oldViewController: UIViewController? = nil, to newViewController: UIViewController) {
        
        oldViewController?.willMove(toParent: self)
        oldViewController?.view.removeFromSuperview()
        oldViewController?.removeFromParent()
        
        addChild(newViewController)
        newViewController.view._autolayout(on: containerView)
        newViewController.didMove(toParent: self)
    }
    
    /// 設定UIViewController透明背景 (當Alert用)
    /// - Present Modally
    /// - Parameter backgroundColor: 背景色
    func _transparent(_ backgroundColor: UIColor = .clear) {
        self._modalStyle(backgroundColor, transitionStyle: .crossDissolve, presentationStyle: .overCurrentContext)
    }
    
    /// [設定UIViewController透明背景 (當Alert用)](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-view-controller-實現-ios-app-的彈出視窗-d1c78563bcde)
    /// - Parameters:
    ///   - backgroundColor: 背景色
    ///   - transitionStyle: 轉場的Style
    ///   - presentationStyle: 彈出的Style
    func _modalStyle(_ backgroundColor: UIColor = .white, transitionStyle: UIModalTransitionStyle = .coverVertical, presentationStyle: UIModalPresentationStyle = .currentContext) {
        self.view.backgroundColor = backgroundColor
        self.modalPresentationStyle = presentationStyle
        self.modalTransitionStyle = transitionStyle
    }
}
