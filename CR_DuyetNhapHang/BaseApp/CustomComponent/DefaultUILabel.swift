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
    
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    } 
}
