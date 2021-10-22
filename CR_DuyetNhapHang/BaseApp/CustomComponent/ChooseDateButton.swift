//
//  ChooseDateButton.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 07/10/2021.
//

import UIKit

class ChooseDateButton: UIButton {
  
    var iconButton:UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "down-arrow")
        return imageView
    }()
    
    let titleButton:DefaultUILabel = {
        let label = DefaultUILabel()
        label.text = "20-09-1991"
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleButton)
        self.titleButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(self.iconButton)
        self.iconButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.titleButton.snp.trailing).offset(10)
            $0.width.height.equalTo(15)
            $0.trailing.equalToSuperview().offset(-5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
