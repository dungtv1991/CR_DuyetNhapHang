//
//  ChiTietDuyetNhapHangInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ChiTietDuyetNhapHangInteractor:ChiTietDuyetNhapHangPresenterToInteractorProtocol {
    
    weak var presenter: ChiTietDuyetNhapHangInteractorToPresenterProtocol?

    func getInfoDuyetNhapHang(soPhieu: Int) {
        APIRequestDuyetNhapHang
            .request(APIRouterDuyetNhapHang.getInfoDuyetNhapHangByID(
                soPhieu: soPhieu),
                     ChiTietDuyetNhapHangEntity.InfoDuyetNhapHangByIDModel.self) { response in
                switch response {
                case .success(let model):
                    self.presenter?.getInfoDuyetNhapHangSuccess(model: model)
                case .failure(let error):
                    self.presenter?.outPutFailed(error: error.message)
                }
                self.presenter?.hideLoading()
            }
    }
    
    func comfirmDuyetNhapHang(soPhieu: Int, status: Int, dataDetail: String, user: String) {
        APIRequestDuyetNhapHang.request(APIRouterDuyetNhapHang.updateInfoDuyetNhapHang(soPhieu: soPhieu, status: status, dataDetail: dataDetail, user: user), ChiTietDuyetNhapHangEntity.UpdateInfoDuyetNhapHangModel.self) { response in
            switch response {
            case .success(let model):
                self.presenter?.comfirmDuyetNhapHangSuccess(model: model)
            case .failure(let error):
                self.presenter?.outPutFailed(error: error.message)
            }
            self.presenter?.hideLoading()
        }
    }
    
}
