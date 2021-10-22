//
//  ChiTietDuyetNhapHangView.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 08/10/2021.
//

import UIKit

class ChiTietDuyetNhapHangView : UIView {
    
    let senderRequestLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = .lightGray
        return label
    }()
    
    let senderRequestLabelResult:DefaultUILabel = {
        let label = DefaultUILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let approvedLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        label.textColor = .lightGray
        return label
    }()
    
    let approvedLabelResult:DefaultUILabel = {
        let label = DefaultUILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let tableView:BaseUITableView = {
        let tableView = BaseUITableView()
        tableView.register(ChiTietDuyetNhapHangTableViewCell.self,
                           forCellReuseIdentifier: ChiTietDuyetNhapHangTableViewCell.identifier)
        tableView.addTopBorder(with: .darkGray, andWidth: 0.7)
        return tableView
    }()
    
    lazy var agreeButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.mainColor
        button.setTitle("Đồng ý", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        return button
    }()
    
    lazy var refuseButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        button.setTitle("Từ chối", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        return button
    }()
    
    let totalAmount:DefaultUILabel = {
        let label = DefaultUILabel()
        label.text = "Tổng tiền : 15.000.000.000"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.red.withAlphaComponent(0.8)
        label.textAlignment = .right
        return label
    }()
    
    let lineView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let header : ChiTietDuyetNhapHangTableViewHeaderCell = {
        let view = ChiTietDuyetNhapHangTableViewHeaderCell()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
    }
    
    private func addView(){
        self.addSubview(self.senderRequestLabel)
        self.addSubview(self.senderRequestLabelResult)
        self.addSubview(self.approvedLabel)
        self.addSubview(self.approvedLabelResult)
        self.addSubview(self.header)
        self.addSubview(self.agreeButton)
        self.addSubview(self.refuseButton)
        self.addSubview(self.totalAmount)
        self.addSubview(self.tableView)
        self.addSubview(self.lineView)
    }
    
    private func autoLayout(){
        
        self.senderRequestLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
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
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.width.equalTo(105)
        }
        self.approvedLabelResult.snp.makeConstraints { make in
            make.top.equalTo(self.approvedLabel.snp.top)
            make.leading.equalTo(self.approvedLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(18)
        }
        self.header.snp.makeConstraints { (make) in
            make.top.equalTo(self.approvedLabelResult.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(35)
        }
        
        self.agreeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(80)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(150)
            make.height.equalTo(35)
        }
        
        self.refuseButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-80)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(150)
            make.height.equalTo(35)
        }
        
        self.totalAmount.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.agreeButton.snp.top).offset(-10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
        }
    
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.header.snp.bottom)
            make.leading.trailing.equalTo(header)
            make.bottom.equalTo(self.totalAmount.snp.top).offset(-10)
        }
        self.lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self.tableView.snp.bottom)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

