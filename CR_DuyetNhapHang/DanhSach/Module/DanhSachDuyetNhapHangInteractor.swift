//
//  DanhSachDuyetNhapHangInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class DanhSachDuyetNhapHangInteractor:DanhSachDuyetNhapHangPresenterToInteractorProtocol {
 
    weak var presenter: DanhSachDuyetNhapHangInteractorToPresenterProtocol?
    
    func getDataShopAndDataStatus() {
        let user = Helper.getUserCode() ?? ""
        APIRequestDuyetNhapHang.request(APIRouterDuyetNhapHang.getDataShopAndDataStatus(user: user), DanhSachDuyetNhapHangEntity.DataShopAndStatusModel.self) { response in
            switch response {
            case .success(let model):
                self.presenter?.getDataShopAndStatusSuccess(model: model)
            case .failure(let error):
                self.presenter?.outPutFailed(error: error.message)
            }
            self.presenter?.hideLoading()
        }
    }

    func getListDuyetNhapHang(soPhieu: Int,
                              fromDate: String,
                              toDate: String,
                              user: String,
                              shopCode: String,
                              isPM: Int,
                              status: String) {
        APIRequestDuyetNhapHang.request(
            APIRouterDuyetNhapHang.getListDuyetNhapHang(
                soPhieu: soPhieu,
                fromDate: fromDate,
                toDate: toDate,
                User: user,
                shopCode: shopCode,
                isPM: isPM,
                status: status), DanhSachDuyetNhapHangEntity.ListDuyetNhapHangModel.self) { response in
                    switch response {
                    case .failure(let error):
                        self.presenter?.outPutFailed(error: error.message)
                    case .success(let model):
                        self.presenter?.getListDuyetNhapHangSuccess(model: model)
                    }
                    self.presenter?.hideLoading()
                }
    }
}
