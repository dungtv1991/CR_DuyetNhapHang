//
//  AttackFileImageView.swift
//  CRServiceIT
//
//  Created by Trần Văn Dũng on 25/09/2021.
//

import UIKit

class AttackFileImageView: UIView {
    
    let imageView:UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
