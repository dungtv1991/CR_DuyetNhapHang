//
//  ChiTietDuyetNhapHangViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import RxSwift
import RxCocoa

class ChiTietDuyetNhapHangViewController: BaseVC<ChiTietDuyetNhapHangView> {
   
    //MARK: - Properties
    var presenter: ChiTietDuyetNhapHangPresenter?
    weak var delegate:ChiTietDuyetNhapHangViewControllerDelegate?
    let bag = DisposeBag()
  
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.getInfoDuyetNhapHang()
        self.title = "Duyệt Nhập Hàng"
        self.bindTableView()
        self.bindButton()
        self.bindData()
    }
 
    deinit {
        print("Denit ChiTietDuyetNhapHangViewController is Success")
    }
    
    //MARK: - Configure
    private func bindButton(){
        self.mainView.agreeButton.rx.tap.subscribe { [weak self] (_) in
            guard let self = self else { return }
            AlertManager
                .shared
                .showAlertMultiOption(
                    title: "Thông Báo",
                    message: "Bạn xác nhận Đồng Ý?",
                    options: "Cancel","OK",
                    viewController: self,
                    buttonAlignment: .horizontal) { (index) in
                        if index == 1 {
                            self.presenter?.comfirmDuyetNhapHang(status: 2)
                        }
                    }
        }.disposed(by: self.bag)

        self.mainView.refuseButton.rx.tap.subscribe { [weak self] (_) in
            guard let self = self else { return }
            AlertManager
                .shared
                .showAlertMultiOption(
                    title: "Thông Báo",
                    message: "Bạn xác nhận Từ chối?",
                    options: "Cancel","OK",
                    viewController: self,
                    buttonAlignment: .horizontal) { (index) in
                        if index == 1 {
                            self.presenter?.comfirmDuyetNhapHang(status: 3)
                        }
                    }
        }.disposed(by: self.bag)
    }
    
    private func bindTableView(){
        self.presenter?.listInfoDuyetNhapHang
            .bind(to: self.mainView.tableView.rx.items(
                cellIdentifier: ChiTietDuyetNhapHangTableViewCell.identifier,
                cellType: ChiTietDuyetNhapHangTableViewCell.self)) { (row, model, cell) in
                    cell.model = model
                    cell.minHeight = 35
                }
                .disposed(by: self.bag)
        
        self.mainView.tableView.rx.willDisplayCell.subscribe(onNext: { [weak self] cell, indexPath in
            if !(self?.presenter?.listInfoDuyetNhapHang.value.isEmpty ?? false) {
                self?.mainView.tableView.backgroundView?.isHidden = true
            }
        })
        .disposed(by: self.bag)
    }
    
    func bindData(){
        self.mainView.senderRequestLabel.text = "Người gửi YC :"
        self.mainView.approvedLabel.text = "Người duyệt :"
    }
    
    //MARK: - Actions
    
    
}

extension ChiTietDuyetNhapHangViewController : ChiTietDuyetNhapHangPresenterToViewProtocol {
    
    func didcomfirmDuyetNhapHangSuccess(message: String) {
        AlertManager
            .shared
            .alertWithViewController(
                title: "Thông báo!",
                message: message,
                titleButton: "OK",
                viewController: self) {
                    self.navigationController?.popViewController(animated: true)
                    self.delegate?.approvedSuccess(status: true)
                }
    }
    
    func didGetInfoDuyetNhapHangSuccess(model: ChiTietDuyetNhapHangEntity.InfoDuyetNhapHangByIDHeader) {
        let totalMoney = SharedCommons.shared.convertCurrencyStringWithCurrencyUnit(currency: model.tongTien ?? 0, currencyUnit: "vi_Vn")
        self.mainView.totalAmount.text = "Tổng tiền : \(totalMoney)"
        self.mainView.senderRequestLabelResult.text = model.nguoiTAO ?? ""
        self.mainView.approvedLabelResult.text = model.nguoiDuyet ?? ""
    }
 
    func outPutFailed(error: String) {
        AlertManager
            .shared
            .alertWithViewController(
                title: "Thông báo!",
                message: error,
                titleButton: "OK",
                viewController: self) {
                    
                }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
    
}


