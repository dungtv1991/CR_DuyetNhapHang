//
//  ChiTietDuyetNhapHangRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ChiTietDuyetNhapHangRouter : ChiTietDuyetNhapHangPresenterToRouterProtocol {
    
    func configureVIPERChiTietDuyetNhapHang() -> ChiTietDuyetNhapHangViewController {
        let view = ChiTietDuyetNhapHangViewController()
        let presenter: ChiTietDuyetNhapHangPresenter = ChiTietDuyetNhapHangPresenter()
        let interactor: ChiTietDuyetNhapHangInteractor = ChiTietDuyetNhapHangInteractor()
        let router:ChiTietDuyetNhapHangPresenterToRouterProtocol = ChiTietDuyetNhapHangRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }

}
