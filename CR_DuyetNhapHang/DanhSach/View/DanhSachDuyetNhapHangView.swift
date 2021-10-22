//
//  DanhSachDuyetNhapHangView.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 07/10/2021.
//

import UIKit

class DanhSachDuyetNhapHangView : UIView {
    
    let fromDate:ChooseDateButton = {
        let button = ChooseDateButton(type: .system)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return button
    }()
    
    let fromToICONImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.image = UIImage(named: "arrow-right")
        return imageView
    }()
    
    let toDate:ChooseDateButton = {
        let button = ChooseDateButton(type: .system)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return button
    }()
    
    let selectedView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        return view
    }()
    
    let lineVerticalView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var typeButton:UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Tình trạng", for: .normal)
        return button
    }()
    
    lazy var searchTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Chọn tình trạng"
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .darkGray
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
        return textField
    }()
    
    lazy var listTableView:BaseUITableView = {
        let tableView = BaseUITableView()
        tableView.register(DanhSachDuyetNhapHangTableViewCell.self,
                           forCellReuseIdentifier: DanhSachDuyetNhapHangTableViewCell.identifier)
        return tableView
    }()
    
    let viewSelectType:UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.fromDate)
        self.addSubview(self.fromToICONImageView)
        self.addSubview(self.toDate)
        self.addSubview(self.typeButton)
        self.addSubview(self.lineVerticalView)
        self.addSubview(self.searchTextField)
        self.addSubview(self.selectedView)
        self.addSubview(self.listTableView)
        self.addSubview(self.viewSelectType)
        
        self.fromDate.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.width.equalTo(130)
            $0.height.equalTo(30)
        }
        self.fromToICONImageView.snp.makeConstraints {
            $0.centerY.equalTo(self.fromDate.snp.centerY)
            $0.leading.equalTo(self.fromDate.snp.trailing).offset(10)
            $0.width.height.equalTo(15)
        }
        self.toDate.snp.makeConstraints {
            $0.top.equalTo(self.fromDate.snp.top)
            $0.leading.equalTo(self.fromToICONImageView.snp.trailing).offset(10)
            $0.width.equalTo(130)
            $0.height.equalTo(30)
        }
        self.typeButton.snp.makeConstraints {
            $0.top.equalTo(self.fromDate.snp.bottom).offset(10)
            $0.leading.equalTo(self.fromDate.snp.leading)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
        }
        self.lineVerticalView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.typeButton)
            $0.width.equalTo(0.5)
            $0.leading.equalTo(self.typeButton.snp.trailing)
        }
        self.searchTextField.snp.makeConstraints {
            $0.top.bottom.equalTo(self.typeButton)
            $0.leading.equalTo(self.lineVerticalView.snp.trailing)
            $0.trailing.equalToSuperview().offset(-10)
        }
        self.selectedView.snp.makeConstraints {
            $0.top.equalTo(self.fromDate.snp.bottom).offset(10)
            $0.leading.equalTo(self.fromDate.snp.leading)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            $0.height.equalTo(40)
        }
        self.insertSubview(self.selectedView, at: 0)
        self.listTableView.snp.makeConstraints {
            $0.top.equalTo(self.selectedView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(self.selectedView)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        self.viewSelectType.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(searchTextField)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
