//
//  ChiTietDuyetNhapHangPresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import RxRelay

//MARK:- Input View to Presenter
class ChiTietDuyetNhapHangPresenter : ChiTietDuyetNhapHangViewToPresenterProtocol {
    
    var soPhieu:Int = 0
    let listInfoDuyetNhapHang:BehaviorRelay<[ChiTietDuyetNhapHangEntity.InfoDuyetNhapHangByID]> = BehaviorRelay(value: [])
    
    weak var view: ChiTietDuyetNhapHangPresenterToViewProtocol?
    
    var interactor: ChiTietDuyetNhapHangPresenterToInteractorProtocol?
    
    var router: ChiTietDuyetNhapHangPresenterToRouterProtocol?
    
    func getInfoDuyetNhapHang() {
        self.view?.showLoading(message: "")
        self.interactor?.getInfoDuyetNhapHang(soPhieu: self.soPhieu)
    }
    
    func comfirmDuyetNhapHang(status:Int) {
        let userCode = Helper.getUserCode() ?? ""
        self.interactor?.comfirmDuyetNhapHang(soPhieu: self.soPhieu, status: status, dataDetail: "", user: userCode)
    }
    
}

//MARK: -Out Presenter To View
extension ChiTietDuyetNhapHangPresenter : ChiTietDuyetNhapHangInteractorToPresenterProtocol {
    
    func comfirmDuyetNhapHangSuccess(model: ChiTietDuyetNhapHangEntity.UpdateInfoDuyetNhapHangModel) {
        if model.isErr != 0 {
            self.view?.outPutFailed(error: model.msg ?? "")
        }else {
            self.view?.didcomfirmDuyetNhapHangSuccess(message: model.msg ?? "")
        }
    }
    
    func getInfoDuyetNhapHangSuccess(model: ChiTietDuyetNhapHangEntity.InfoDuyetNhapHangByIDModel) {
        self.listInfoDuyetNhapHang.accept(model.infoDuyetNhapHangByID ?? [])
        if let modelHeader = model.infoDuyetNhapHangByIDHeader {
            self.view?.didGetInfoDuyetNhapHangSuccess(model: modelHeader)
        }else {
            self.view?.outPutFailed(error: "Lỗi Server. Không nhận được thông tin tổng tiền của phiếu")
        }
    }
  
    func outPutFailed(error: String) {
        self.view?.outPutFailed(error: error)
    }
    
    func showLoading(message: String) {
        self.view?.showLoading(message: message)
    }
    
    func hideLoading() {
        self.view?.hideLoading()
    }

}
