//
//  DefaultUILabel.swift
//  BaoCaoHinhAnhTrungBay
//
//  Created by Trần Văn Dũng on 09/07/2021.
//

import UIKit
import SwiftUI


class DefaultUILabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = .systemFont(ofSize: 15)
        self.textColor = .darkGray
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
