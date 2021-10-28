//
//  ChiTietDuyetNhapHangTableViewCell.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 08/10/2021.
//

import UIKit

class ChiTietDuyetNhapHangTableViewCell: BaseTableViewCell {
    
    static let identifier:String = "ChiTietDuyetNhapHangTableViewCell"
    var minHeight: CGFloat?
    var model:ChiTietDuyetNhapHangEntity.InfoDuyetNhapHangByID? {
        didSet {
            self.bindingData()
        }
    }
    
    private let sanPhamLabel:UILabel = {
        let lable = UILabel()
        lable.text = "Loading..."
        lable.numberOfLines = 0
        lable.textColor = .darkGray
        lable.font = .systemFont(ofSize: 13, weight: .semibold)
        lable.textAlignment = .left
        return lable
    }()
    
    private let viewSanPham:UIView = {
        let view = UIView()
        return view
    }()
    
    private let soLuongLabel:UILabel = {
        let lable = UILabel()
        lable.text = "Loading..."
        lable.textColor = .darkGray
        lable.font = .systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .center
        return lable
    }()
    private let donViTinhLabel:UILabel = {
        let lable = UILabel()
        lable.text = "Loading..."
        lable.textColor = .darkGray
        lable.font = .systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .center
        return lable
    }()
    private let donGia:DefaultUILabel = {
        let lable = DefaultUILabel()
        lable.text = "Loading..."
        lable.textColor = .darkGray
        lable.font = .systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .right
        lable.textInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        return lable
    }()
    private let thanhTien:DefaultUILabel = {
        let lable = DefaultUILabel()
        lable.numberOfLines = 0
        lable.text = "Loading..."
        lable.textColor = .darkGray
        lable.font = .systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .right
        lable.textInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [viewSanPham,soLuongLabel,donViTinhLabel,donGia,thanhTien])
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        self.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
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
        
        self.viewSanPham.addSubview(self.sanPhamLabel)
        self.sanPhamLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(5)
        }

        self.viewSanPham.addRightBorder(with: .darkGray, andWidth: 0.5)
        self.soLuongLabel.addRightBorder(with: .darkGray, andWidth: 0.5)
        self.donViTinhLabel.addRightBorder(with: .darkGray, andWidth: 0.5)
        self.donGia.addRightBorder(with: .darkGray, andWidth: 0.5)
        self.addBottomBorder(with: .darkGray, andWidth: 0.5)
        self.viewSanPham.addLeftBorder(with: .darkGray, andWidth: 0.5)
        self.thanhTien.addRightBorder(with: .darkGray, andWidth: 0.5)
        
    }
    
    private func bindingData(){
        let donGia = SharedCommons.shared.convertCurrencyString(currency: self.model?.price ?? 0)
        let thanhTien = SharedCommons.shared.convertCurrencyString(currency: self.model?.totalPrice ?? 0)
        self.sanPhamLabel.text = self.model?.itemName ?? ""
        self.donViTinhLabel.text = self.model?.dvtName ?? ""
        self.soLuongLabel.text = "\(self.model?.quantity ?? 0)"
        self.donGia.text = donGia
        self.thanhTien.text = thanhTien
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        self.sanPhamLabel.text = ""
        self.donViTinhLabel.text = ""
        self.soLuongLabel.text = ""
        self.donGia.text = ""
        self.thanhTien.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = minHeight else { return size }
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }
    
}
