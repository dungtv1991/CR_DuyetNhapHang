//
//  ChiTietDuyetNhapHangProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol ChiTietDuyetNhapHangViewToPresenterProtocol: class {
    var view: ChiTietDuyetNhapHangPresenterToViewProtocol? { get set }
    var interactor: ChiTietDuyetNhapHangPresenterToInteractorProtocol? { get set }
    var router: ChiTietDuyetNhapHangPresenterToRouterProtocol? { get set }
    func getInfoDuyetNhapHang()
    func comfirmDuyetNhapHang(status:Int)
}

protocol ChiTietDuyetNhapHangPresenterToInteractorProtocol: class {
    var presenter:ChiTietDuyetNhapHangInteractorToPresenterProtocol? { get set }
    func getInfoDuyetNhapHang(soPhieu:Int)
    func comfirmDuyetNhapHang(soPhieu : Int,
                               status : Int,
                               dataDetail: String,
                               user : String)
}

protocol ChiTietDuyetNhapHangInteractorToPresenterProtocol:class {
    func getInfoDuyetNhapHangSuccess(model:ChiTietDuyetNhapHangEntity.InfoDuyetNhapHangByIDModel)
    func comfirmDuyetNhapHangSuccess(model:ChiTietDuyetNhapHangEntity.UpdateInfoDuyetNhapHangModel)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ChiTietDuyetNhapHangPresenterToViewProtocol:class {
    func didGetInfoDuyetNhapHangSuccess(model:ChiTietDuyetNhapHangEntity.InfoDuyetNhapHangByIDHeader)
    func outPutFailed(error:String)
    func didcomfirmDuyetNhapHangSuccess(message:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ChiTietDuyetNhapHangPresenterToRouterProtocol:class {
    func configureVIPERChiTietDuyetNhapHang() -> ChiTietDuyetNhapHangViewController
}

protocol ChiTietDuyetNhapHangViewControllerDelegate:class {
    func approvedSuccess(status:Bool)
}
