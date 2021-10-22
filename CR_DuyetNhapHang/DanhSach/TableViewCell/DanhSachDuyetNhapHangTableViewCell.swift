//
//  DanhSachDuyetNhapHangTableViewCell.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 07/10/2021.
//

import UIKit

class DanhSachDuyetNhapHangTableViewCell : BaseTableViewCell {
    
    static let identifier:String = "DanhSachDuyetNhapHangTableViewCell"
    
    var model:DanhSachDuyetNhapHangEntity.ListDuyetNhapHang?{
        didSet {
            self.bindData()
        }
    }
    
    private let codeLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = Color.mainColor
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let calendarLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textAlignment = .right
        return label
    }()
    
    private let lineView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let soCTLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private let soCTLabelResult:DefaultUILabel = {
        let label = DefaultUILabel()
        return label
    }()
    
    private let shopLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private let shopLabelResult:DefaultUILabel = {
        let label = DefaultUILabel()
        return label
    }()
    
    private let senderRequestLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private let senderRequestLabelResult:DefaultUILabel = {
        let label = DefaultUILabel()
        return label
    }()
    
    private let approvedLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private let approvedLabelResult:DefaultUILabel = {
        let label = DefaultUILabel()
        return label
    }()
    
    private let statusLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private let statusLabelResult:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = Color.mainColor
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let contentLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private let contentLabelResult:DefaultUILabel = {
        let label = DefaultUILabel()
        return label
    }()
    
    private let boderView:UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.autoLayout()
        self.bindData()
    }
    
    func bindData(){
        self.codeLabel.text = "Số phiếu \(self.model?.docentry ?? 0)"
        self.calendarLabel.text = self.model?.createDate
        self.soCTLabel.text = "Số CT :"
        self.soCTLabelResult.text = "\(self.model?.docentryNhapHang ?? 0)"
        self.shopLabel.text = "Shop :"
        self.shopLabelResult.text = self.model?.shopName ?? ""
        self.senderRequestLabel.text = "Người gửi YC :"
        self.senderRequestLabelResult.text = model?.createByName ?? ""
        self.approvedLabel.text = "Người duyệt :"
        self.approvedLabelResult.text = self.model?.employeeApproveName ?? ""
        self.statusLabel.text = "Tình trạng :"
        var color:UIColor = Color.mainColor
        var showHideApprovedResult:Bool = false
        switch self.model?.status {
        case 1:
            color = Color.mainColor
            showHideApprovedResult = true
        case 2:
            color = UIColor.systemGreen
            showHideApprovedResult = false
        default:
            color = UIColor.red
            showHideApprovedResult = false
        }
        self.approvedLabelResult.isHidden = showHideApprovedResult
        self.statusLabelResult.textColor = color
        self.statusLabelResult.text = self.model?.statusName ?? ""
        self.contentLabel.text = "Nội dung :"
        self.contentLabelResult.text = self.model?.content ?? ""
    }
    
    private func addView(){
        self.addSubview(self.codeLabel)
        self.addSubview(self.calendarLabel)
        self.addSubview(self.lineView)
        self.addSubview(self.soCTLabel)
        self.addSubview(self.soCTLabelResult)
        self.addSubview(self.shopLabel)
        self.addSubview(self.shopLabelResult)
        self.addSubview(self.senderRequestLabel)
        self.addSubview(self.senderRequestLabelResult)
        self.addSubview(self.approvedLabel)
        self.addSubview(self.approvedLabelResult)
        self.addSubview(self.statusLabel)
        self.addSubview(self.statusLabelResult)
        self.addSubview(self.contentLabel)
        self.addSubview(self.contentLabelResult)
        self.addSubview(self.boderView)
    }
    
    private func autoLayout(){
        self.codeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
            make.height.greaterThanOrEqualTo(18)
        }
        self.calendarLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(18)
        }
        self.lineView.snp.makeConstraints { make in
            make.top.equalTo(self.codeLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.codeLabel.snp.leading)
            make.trailing.equalTo(self.calendarLabel.snp.trailing)
            make.height.equalTo(0.5)
        }
        self.soCTLabel.snp.makeConstraints { make in
            make.top.equalTo(self.lineView.snp.bottom).offset(10)
            make.leading.equalTo(self.lineView.snp.leading)
            make.width.equalTo(105)
        }
        self.soCTLabelResult.snp.makeConstraints { make in
            make.top.equalTo(self.soCTLabel.snp.top)
            make.leading.equalTo(self.soCTLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(18)
        }
        self.shopLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soCTLabelResult.snp.bottom).offset(10)
            make.leading.equalTo(self.lineView.snp.leading)
            make.width.equalTo(105)
        }
        self.shopLabelResult.snp.makeConstraints { make in
            make.top.equalTo(self.shopLabel.snp.top)
            make.leading.equalTo(self.shopLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(18)
        }
        self.senderRequestLabel.snp.makeConstraints { make in
            make.top.equalTo(self.shopLabelResult.snp.bottom).offset(10)
            make.leading.equalTo(self.lineView.snp.leading)
            make.width.equalTo(105)
        }
        self.senderRequestLabelResult.snp.makeConstraints { make in
            make.top.equalTo(self.senderRequestLabel.snp.top)
            make.leading.equalTo(self.senderRequestLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(18)
        }
        self.approvedLabel.snp.makeConstraints { make in
            make.top.equalTo(self.senderRequestLabelResult.snp.bottom).offset(10)
            make.leading.equalTo(self.lineView.snp.leading)
            make.width.equalTo(105)
        }
        self.approvedLabelResult.snp.makeConstraints { make in
            make.top.equalTo(self.approvedLabel.snp.top)
            make.leading.equalTo(self.approvedLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(18)
        }
        self.statusLabel.snp.makeConstraints { make in
            make.top.equalTo(self.approvedLabelResult.snp.bottom).offset(10)
            make.leading.equalTo(self.lineView.snp.leading)
            make.width.equalTo(105)
        }
        self.statusLabelResult.snp.makeConstraints { make in
            make.top.equalTo(self.statusLabel.snp.top)
            make.leading.equalTo(self.statusLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(18)
        }
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.statusLabelResult.snp.bottom).offset(10)
            make.leading.equalTo(self.lineView.snp.leading)
            make.width.equalTo(105)
        }
        self.contentLabelResult.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp.top)
            make.leading.equalTo(self.contentLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-15)
            make.height.greaterThanOrEqualTo(18)
        }
        self.boderView.snp.makeConstraints { make in
            make.top.equalTo(self.codeLabel.snp.top).offset(-10)
            make.leading.equalTo(self.codeLabel.snp.leading).offset(-10)
            make.bottom.equalTo(self.contentLabelResult.snp.bottom).offset(10)
            make.trailing.equalTo(self.contentLabelResult.snp.trailing).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.codeLabel.text = " "
        self.calendarLabel.text = " "
        self.soCTLabel.text = "Số CT :"
        self.soCTLabelResult.text = " "
        self.shopLabel.text = "Shop :"
        self.shopLabelResult.text = " "
        self.senderRequestLabel.text = "Người gửi YC :"
        self.senderRequestLabelResult.text = " "
        self.approvedLabel.text = "Người duyệt :"
        self.approvedLabelResult.text = " "
        self.statusLabel.text = "Tình trạng :"
        self.statusLabelResult.text = " "
        self.contentLabel.text = "Nội dung :"
        self.contentLabelResult.text = " "
    }
    
    override func layoutSubviews() {
        print(self.approvedLabelResult.frame.height)
    }
    
}
