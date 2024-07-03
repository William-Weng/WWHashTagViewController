//
//  CellView.swift
//  Example
//
//  Created by William.Weng on 2024/7/3.
//

import UIKit

// MARK: - 自定義的CellView
final class CellView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var myLabel: UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromXib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromXib()
    }
}

// MARK: - 小工具
private extension CellView {
    
    /// 讀取Nib畫面 => 加到View上面
    func initViewFromXib() {
        
        let bundle = Bundle.main
        let name = String(describing: CellView.self)
        
        bundle.loadNibNamed(name, owner: self, options: nil)
        contentView.frame = bounds
        
        addSubview(contentView)
    }
}
