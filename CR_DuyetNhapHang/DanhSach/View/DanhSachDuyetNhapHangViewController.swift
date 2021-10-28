//
//  DanhSachDuyetNhapHangViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import RxSwift
import RxCocoa

class DanhSachDuyetNhapHangViewController: BaseVC<DanhSachDuyetNhapHangView> {
   
    //MARK: - Properties
    var presenter: DanhSachDuyetNhapHangPresenter?
    let bag = DisposeBag()
 
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.bindTableView()
        self.bindTextField()
        self.bindButton()
        self.bindSelectType()
        self.configureNavigationBar()
        self.bindUI()
    }
    
    private func bindUI(){

        self.presenter?.fromDate
            .asObservable()
            .bind(to: self.mainView.fromDate.titleButton.rx.text)
            .disposed(by: self.bag)
        
        self.presenter?.toDate
            .asObservable()
            .bind(to: self.mainView.toDate.titleButton.rx.text)
            .disposed(by: self.bag)
    }
    
    private func configureNavigationBar(){
        self.title = "Danh Sách Duyệt Nhập Hàng"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "refreshICON"), style: .plain, target: self, action: #selector(self.refreshHandle))
    }
    
    deinit {
        print("Denit DanhSachDuyetNhapHangViewController is Success")
    }
    
    //MARK: - Configure
    private func bindTextField(){
        self.mainView.searchTextField
            .rx
            .controlEvent([.editingChanged])
            .asObservable()
            .subscribe { [weak self] _ in
            self?.presenter?.filterListDuyetNhapHang(searchStatus: nil,searchSoCT: self?.mainView.searchTextField.text ?? "")
        }.disposed(by: self.bag)
    }
    
    private func bindSelectType(){
        let tapGesture = UITapGestureRecognizer()
        self.mainView.viewSelectType.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.bind(onNext: { [weak self] recognizer in
            guard let self = self else { return }
            self.presenter?.chooseType = 1
            if self.presenter?.typeSearch == 0 {
                self.presenter?.typeTextField = 0
                DispatchQueue.global(qos: .background).async {
                    var dataStatus:[String] = []
                    self.presenter?.dataStatus.forEach({ item in
                        dataStatus.append(item.name ?? "")
                    })
                    DispatchQueue.main.async {
                        AlertManager.shared.showDropDown(frame: self.mainView.searchTextField.frame, viewController: self, data: dataStatus,isSearch: false)
                    }
                }
                
            }
            if self.presenter?.typeSearch == 2 {
                self.presenter?.typeTextField = 2
                var dataShop:[String] = []
                self.presenter?.dataShop.forEach({ item in
                    dataShop.append(item.shopName ?? "")
                })
                AlertManager.shared.showDropDown(frame: self.mainView.searchTextField.frame, viewController: self, data: dataShop,isSearch: true)
            }
        }).disposed(by: self.bag)
    }
    
    private func bindButton(){
        
        self.mainView.fromDate.rx.tap.subscribe { [weak self] _ in
            self?.presenter?.isFromDate = true
            self?.showDatePicker()
        }.disposed(by: bag)
        
        self.mainView.toDate.rx.tap.subscribe { [weak self] _ in
            self?.presenter?.isFromDate = false
            self?.showDatePicker()
        }.disposed(by: bag)
        
        self.mainView.typeButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            self.presenter?.chooseType = 0
            AlertManager.shared.showDropDown(frame: self.mainView.typeButton.frame, viewController: self, data: ["Tình trạng","Số CT nhập","Shop"],isSearch: false)
        }.disposed(by: self.bag)
    }
    
    private func bindTableView(){
        self.presenter?.listDuyetNhapHangFilter
            .bind(to: self.mainView.listTableView.rx.items(
                cellIdentifier: DanhSachDuyetNhapHangTableViewCell.identifier,
                cellType: DanhSachDuyetNhapHangTableViewCell.self)) { (row, model, cell) in
                    cell.model = model
                }
                .disposed(by: self.bag)
        
        self.mainView.listTableView.rx.willDisplayCell.subscribe(onNext: { [weak self] cell, indexPath in
            if !(self?.presenter?.listDuyetNhapHang.value.isEmpty ?? false) {
                self?.mainView.listTableView.backgroundView?.isHidden = true
            }
        })
        .disposed(by: self.bag)
        
        self.mainView.listTableView.rx.itemSelected
            .subscribe(onNext: { [weak self]indexPath in
                guard let self = self else { return }
                let soPhieu = self.presenter?.listDuyetNhapHangFilter.value[indexPath.row].docentry ?? 0
                let soCT = self.presenter?.listDuyetNhapHangFilter.value[indexPath.row].docentryNhapHang ?? 0
                self.moveToChiTietDuyetNhapHang(soPhieu: soPhieu,soCT: soCT)
            }).disposed(by: self.bag)
    }

    //MARK: - Actions
    @objc private func refreshHandle(){
        self.presenter?.refreshHandle()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.mainView.typeButton.setTitle("Tình Trạng", for: .normal)
            self.mainView.searchTextField.text = ""
            self.mainView.searchTextField.placeholder = "Chọn tình trạng"
        }
    }
    
    private func showDatePicker() {
        let vc = DatePickerController()
        vc.isMultipleSelection = false
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    private func moveToChiTietDuyetNhapHang(soPhieu:Int,soCT:Int){
        let vc = ChiTietDuyetNhapHangRouter().configureVIPERChiTietDuyetNhapHang()
        vc.presenter?.soPhieu = soPhieu
        vc.title = "Duyệt Số CT : \(soCT)"
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DanhSachDuyetNhapHangViewController : DanhSachDuyetNhapHangPresenterToViewProtocol {
    func didSelectedType(isInput: Bool, placeholder: String) {
        if self.presenter?.chooseType == 0 {
            DispatchQueue.main.async {
                self.mainView.searchTextField.text = ""
                self.mainView.viewSelectType.isHidden = isInput
                self.mainView.searchTextField.placeholder = placeholder
            }
//            if isInput == true {
                self.presenter?.shopCode.accept("")
                self.presenter?.status.accept("")
                self.presenter?.getListDuyetNhapHang(
                    formDate: self.presenter?.fromDate.value ?? "",
                    toDate:  self.presenter?.toDate.value ?? ""
                )
//            }
            
        }
    }

    func outPutFailed(error: String) {
        AlertManager
            .shared
            .alertWithViewController(
                title: "Error!",
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

extension DanhSachDuyetNhapHangViewController : DropDownViewDelegate {
    
    func selectItem(index: Int, title: String) {
  
        if self.presenter?.chooseType == 0 {
            DispatchQueue.main.async { [weak self] in
                self?.mainView.typeButton.setTitle(title, for: .normal)
            }
            self.presenter?.searchType(index: index)
            self.presenter?.typeSearch = index
        }
        
        if self.presenter?.chooseType == 1 {
            
            self.mainView.searchTextField.text = title
            
            if self.presenter?.typeTextField == 0 {
                let indexStatus = "\(self.presenter?.dataStatus[index].id ?? 0)"
                self.presenter?.filterListDuyetNhapHang(searchStatus: Int(indexStatus))
            }
 
            if self.presenter?.typeTextField == 2 {
                let array = self.presenter?.dataShop.filter { $0.shopName == title }
                if let shop = array?[0] {
                    self.presenter?.filterListDuyetNhapHang(searchStatus: nil,searchShop: shop.shopCode ?? "")
                }
            }
            
        }
    }
}

extension DanhSachDuyetNhapHangViewController : ChiTietDuyetNhapHangViewControllerDelegate {
    func approvedSuccess(status: Bool) {
        self.presenter?.getListDuyetNhapHang(
            formDate:self.presenter?.fromDate.value ?? "",
            toDate:self.presenter?.toDate.value ?? ""
        )
    }
}

extension DanhSachDuyetNhapHangViewController : DatePickerControllerDelegate {
    func chooseDatePicker(dateString: String) {
        if self.presenter?.isFromDate == true {
            
            let arrayFormDate:[String] = dateString.components(separatedBy: "-")
            let fromDates:String = arrayFormDate[2] + arrayFormDate[1] + arrayFormDate[0]
            
            let arrayToDate:[String] = self.presenter?.toDate.value.components(separatedBy: "-") ?? []
            let toDates:String = arrayToDate[2] + arrayToDate[1] + arrayToDate[0]
            
            if fromDates > toDates {
                self.outPutFailed(error: "Không thể chọn tìm kiếm từ ngày \(arrayFormDate[0] + "/" + arrayFormDate[1] + "/" + arrayFormDate[2]) đến ngày \(arrayToDate[0] + "/" + arrayToDate[1] + "/" + arrayToDate[2]) được. Vui lòng chọn lại")
                return
            }
            self.presenter?.fromDate.accept(dateString)
        }else {
            self.presenter?.toDate.accept(dateString)
        }
        
        let fromDate =  self.presenter?.fromDate.value ?? ""
        let toDate =  self.presenter?.toDate.value ?? ""
        self.presenter?.getListDuyetNhapHang(formDate: fromDate, toDate: toDate)
    }
}

