//
//  SwitchCollectionViewCell.swift
//  國泰IOS應徵者林造文作品
//
//  Created by Jef2un_628 on 2023/6/5.
//

import UIKit

class SwitchCollectionViewCell: UICollectionViewCell {
    static let identify = "SwitchCollectionViewCell"

    public var presentView = FriendsTableView()
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(presentView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        presentView.frame = contentView.bounds
    }
}
