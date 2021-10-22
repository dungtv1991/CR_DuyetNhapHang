//
//  ChiTietDuyetNhapHangTableViewHeaderCell.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 08/10/2021.
//

import UIKit

class ChiTietDuyetNhapHangTableViewHeaderCell: UIView {
    
    private let sanPhamLabel:UILabel = {
        let lable = UILabel()
        lable.text = "Sản phẩm"
        lable.textColor = .white
        lable.font = .systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .center
        return lable
    }()
    private let soLuongLabel:UILabel = {
        let lable = UILabel()
        lable.text = "SL"
        lable.textColor = .white
        lable.font = .systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .center
        return lable
    }()
    private let donViTinhLabel:UILabel = {
        let lable = UILabel()
        lable.text = "ĐVT"
        lable.textColor = .white
        lable.font = .systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .center
        return lable
    }()
    private let donGia:UILabel = {
        let lable = UILabel()
        lable.text = "Đơn giá"
        lable.textColor = .white
        lable.font = .systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .center
        return lable
    }()
    private let thanhTien:UILabel = {
        let lable = UILabel()
        lable.text = "Thành tiền"
        lable.textColor = .white
        lable.font = .systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .center
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.mainColor
        let stack = UIStackView(arrangedSubviews: [sanPhamLabel,soLuongLabel,donViTinhLabel,donGia,thanhTien])
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        self.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalTo(self.safeAreaLayoutGuide)
        }
        self.thanhTien.snp.makeConstraints { (make) in
            make.width.equalTo(85)
        }
        self.soLuongLabel.snp.makeConstraints { (make) in
            make.width.equalTo(50)
        }
        self.donViTinhLabel.snp.makeConstraints { (make) in
            make.width.equalTo(45)
        }
        self.donGia.snp.makeConstraints { (make) in
            make.width.equalTo(75)
        }
        self.sanPhamLabel.addRightBorder(with: .white, andWidth: 0.5)
        self.soLuongLabel.addRightBorder(with: .white, andWidth: 0.5)
        self.donViTinhLabel.addRightBorder(with: .white, andWidth: 0.5)
        self.donGia.addRightBorder(with: .white, andWidth: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
