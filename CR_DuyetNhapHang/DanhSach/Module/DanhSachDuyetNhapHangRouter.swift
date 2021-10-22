//
//  DanhSachDuyetNhapHangRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class DanhSachDuyetNhapHangRouter : DanhSachDuyetNhapHangPresenterToRouterProtocol {

    var view: DanhSachDuyetNhapHangViewController!

    func configureVIPERDanhSachDuyetNhapHang() -> DanhSachDuyetNhapHangViewController {
        self.view = DanhSachDuyetNhapHangViewController()
        let presenter: DanhSachDuyetNhapHangPresenter = DanhSachDuyetNhapHangPresenter()
        let interactor: DanhSachDuyetNhapHangInteractor = DanhSachDuyetNhapHangInteractor()
        let router:DanhSachDuyetNhapHangPresenterToRouterProtocol = DanhSachDuyetNhapHangRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }
    
    func pushToViewController() {
        let vc = BaseViewController()
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
}
