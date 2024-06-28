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
    private var hashTagViewController: WWHashTagViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        refreashAction()
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
    
    func title(_ hashTagViewController: WWHashTagViewController, with indexPath: IndexPath) -> String? {
        return "\(productName) \(indexPath.row)"
    }
    
    func font(_ hashTagViewController: WWHashTagViewController, with indexPath: IndexPath) -> UIFont {
        return .systemFont(ofSize: 16, weight: .bold)
    }
    
    func layoutType(_ hashTagViewController: WWHashTagViewController) -> WWHashTagViewController.CollectionViewLayoutType {
        return .default(type: .vertical(count: 3), itemHeight: 56, minimumLineSpacing: 5)
    }
    
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, didSelectItemBackgroundColorAt indexPath: IndexPath) -> WWHashTagViewController.ColorInformation {
        return (selected: .red, unselected: .lightText)
    }
    
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, didSelectItemTextColorAt indexPath: IndexPath) -> WWHashTagViewController.ColorInformation {
        return (selected: .white, unselected: .black)
    }
    
    func hashTagViewController(_ hashTagViewController: WWHashTagViewController, didSelectItemAt indexPath: IndexPath, forItems items: Set<IndexPath>) {
        myLabel.text = "\(productName) \(indexPath.row)"
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
             
        myContainerView._changeContainerView(parent: self, to: hashTagViewController)
    }
    
    /// 更新資料
    func refreashAction() {
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
        if (!isOn) { count = 0; heightConstraint.constant = 0; return }
        
        count = 5
        heightConstraint.constant = height
    }
}
