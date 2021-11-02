//
//  DanhSachDuyetNhapHangPresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

//MARK:- Input View to Presenter
class DanhSachDuyetNhapHangPresenter : DanhSachDuyetNhapHangViewToPresenterProtocol {

    var typeSearch:Int = 0
    var typeTextField:Int = 0 //0 : Chọn loại tình trạng, 2 : Chọn shop
    var chooseType:Int = 0
    var indexSearchType:Int = 0
    var isFromDate:Bool = false
    
    var soPhieu:BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var fromDate:BehaviorRelay<String> = BehaviorRelay(value: "")
    var toDate:BehaviorRelay<String> = BehaviorRelay(value: "")
    var status:BehaviorRelay<String> = BehaviorRelay(value: "")
    var shopCode:BehaviorRelay<String> = BehaviorRelay(value: "")
    var listDuyetNhapHang:BehaviorRelay<[DanhSachDuyetNhapHangEntity.ListDuyetNhapHang]> = BehaviorRelay(value: [])
    var listDuyetNhapHangFilter:BehaviorRelay<[DanhSachDuyetNhapHangEntity.ListDuyetNhapHang]> = BehaviorRelay(value: [])
    var dataShop:[DanhSachDuyetNhapHangEntity.DataShop] = []
    var dataStatus:[DanhSachDuyetNhapHangEntity.DataStatus] = []
    
    weak var view: DanhSachDuyetNhapHangPresenterToViewProtocol?

    var interactor: DanhSachDuyetNhapHangPresenterToInteractorProtocol?
    
    var router: DanhSachDuyetNhapHangPresenterToRouterProtocol?
    
    func viewDidLoad() {
        self.toDate.accept(self.getCurrentDate())
        self.fromDate.accept(self.get3DaysAgo())
        self.getListDuyetNhapHang(formDate: fromDate.value, toDate: toDate.value)
    }
    
    func getListDuyetNhapHang(formDate:String,toDate:String) {
        self.view?.showLoading(message: "")
        self.interactor?.getDataShopAndDataStatus()
        
        let arrayToDate:[String] = toDate.components(separatedBy: "-")
        let toDates:String = arrayToDate[2] + arrayToDate[1] + arrayToDate[0]
        
        let arrayFormDate:[String] = formDate.components(separatedBy: "-")
        let fromDates:String = arrayFormDate[2] + arrayFormDate[1] + arrayFormDate[0]
        
        self.interactor?.getListDuyetNhapHang(
            soPhieu: 0,
            fromDate: fromDates,
            toDate: toDates,
            user: Helper.getUserCode() ?? "",
            shopCode: "",
            isPM: 0,
            status: "")
    }
    
    func searchType(index: Int) {
        var isShow:Bool = false
        var placeHolder:String = ""
        if self.indexSearchType == index {
            return
        }
        switch index {
        case 0:
            isShow = false
            placeHolder = "Chọn tình trạng"
        case 1:
            isShow = true
            placeHolder = "Nhập số chứng từ cần tìm"
        default:
            isShow = false
            placeHolder = "Chọn shop"
        }
        self.indexSearchType = index
        self.view?.didSelectedType(isInput: isShow, placeholder: placeHolder)
    }

    private func getCurrentDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    private func get3DaysAgo() -> String {
        let today = Date()
        let thirtyDaysBeforeToday = Calendar.current.date(byAdding: .day, value: -3, to: today)!
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: thirtyDaysBeforeToday)
        return formattedDate
    }
    
    func filterListDuyetNhapHang(searchStatus: Int?, searchSoCT:String = "",searchShop: String = ""){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            if searchStatus != nil {
                self.status.accept("\(searchStatus ?? 0)")
                self.shopCode.accept("")
                self.filterListDuyetNhapHang(self.listDuyetNhapHang.value)
            }else if searchSoCT != "" {
                self.filterContentForSearchText(searchText: searchSoCT)
            }else if searchShop != "" {
                self.status.accept("")
                self.shopCode.accept(searchShop)
                self.filterListDuyetNhapHang(self.listDuyetNhapHang.value)
            }else {
                self.listDuyetNhapHangFilter.accept(self.listDuyetNhapHang.value)
            }
        }
    }

    private func filterContentForSearchText(searchText: String) {
        let options = String.CompareOptions.caseInsensitive
        let filteredItems = self.listDuyetNhapHang.value
            .filter{String($0.docentryNhapHang ?? 0)
                .range(of: searchText, options: options) != nil}
            .sorted{ (String(
                $0.docentryNhapHang ?? 0).hasPrefix(searchText) ? 0 : 1) < (String($1.docentryNhapHang ?? 0).hasPrefix(searchText) ? 0 : 1) }
        self.listDuyetNhapHangFilter.accept([])
        self.listDuyetNhapHangFilter.accept(
            filteredItems.sorted(by: { $0.docentry ?? 0 > $1.docentry ?? 0})
        )
    }
    
    func refreshHandle(){
        self.soPhieu.accept(0)
        self.status.accept("")
        self.typeSearch = 0
        self.typeTextField = 0
        self.chooseType = 0
        self.listDuyetNhapHang.accept([])
        self.listDuyetNhapHangFilter.accept([])
        self.dataShop.removeAll()
        self.dataStatus.removeAll()
        self.viewDidLoad()
    }
}

//MARK: -Out Presenter To View
extension DanhSachDuyetNhapHangPresenter : DanhSachDuyetNhapHangInteractorToPresenterProtocol {
    
    private func filterListDuyetNhapHang(_ model: [DanhSachDuyetNhapHangEntity.ListDuyetNhapHang]) {
        let listDuyetNhapHang = model
        if self.status.value != "" {
            let listFilter = listDuyetNhapHang.filter { $0.status == Int(self.status.value) }
            self.listDuyetNhapHangFilter.accept([])
            self.listDuyetNhapHangFilter.accept(
                listFilter.sorted(by: { $0.docentry ?? 0 > $1.docentry ?? 0})
            )
        } else if self.shopCode.value != "" {
            let listFilter = listDuyetNhapHang.filter { $0.shopCode == self.shopCode.value }
            self.listDuyetNhapHangFilter.accept([])
            self.listDuyetNhapHangFilter.accept(
                listFilter.sorted(by: { ($0.status ?? 0, $1.docentry ?? 0) < ($1.status ?? 0,$0.docentry ?? 0) })
            )
        } else {
            self.listDuyetNhapHangFilter.accept(
                listDuyetNhapHang.sorted(by: { ($0.status ?? 0, $1.docentry ?? 0) < ($1.status ?? 0,$0.docentry ?? 0) })
            )
        }
    }
    
    func getListDuyetNhapHangSuccess(model: DanhSachDuyetNhapHangEntity.ListDuyetNhapHangModel) {
        self.listDuyetNhapHang.accept(model.listDuyetNhapHang ?? [])
        self.filterListDuyetNhapHang(model.listDuyetNhapHang ?? [])
    }

    func getDataShopAndStatusSuccess(model:DanhSachDuyetNhapHangEntity.DataShopAndStatusModel) {
        self.dataShop = model.dataShop ?? []
        self.dataStatus = model.dataStatus ?? []
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
