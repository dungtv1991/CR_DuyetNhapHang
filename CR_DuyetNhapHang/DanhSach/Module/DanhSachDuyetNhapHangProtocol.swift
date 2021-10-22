//
//  DanhSachDuyetNhapHangProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol DanhSachDuyetNhapHangViewToPresenterProtocol: class {
    var view: DanhSachDuyetNhapHangPresenterToViewProtocol? { get set }
    var interactor: DanhSachDuyetNhapHangPresenterToInteractorProtocol? { get set }
    var router: DanhSachDuyetNhapHangPresenterToRouterProtocol? { get set }
    func getListDuyetNhapHang(formDate:String,toDate:String)
    func viewDidLoad()
    func searchType(index:Int)
}

protocol DanhSachDuyetNhapHangPresenterToInteractorProtocol: class {
    var presenter:DanhSachDuyetNhapHangInteractorToPresenterProtocol? { get set }
    func getDataShopAndDataStatus()
    func getListDuyetNhapHang(soPhieu:Int,
                              fromDate:String,
                              toDate:String,
                              user:String,
                              shopCode:String,
                              isPM:Int,
                              status:String
    )
}

protocol DanhSachDuyetNhapHangInteractorToPresenterProtocol:class {
    func getDataShopAndStatusSuccess(model:DanhSachDuyetNhapHangEntity.DataShopAndStatusModel)
    func getListDuyetNhapHangSuccess(model:DanhSachDuyetNhapHangEntity.ListDuyetNhapHangModel)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol DanhSachDuyetNhapHangPresenterToViewProtocol:class {
    func outPutFailed(error:String)
    func didSelectedType(isInput:Bool,placeholder:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol DanhSachDuyetNhapHangPresenterToRouterProtocol:class {
    func configureVIPERDanhSachDuyetNhapHang() -> DanhSachDuyetNhapHangViewController
}

