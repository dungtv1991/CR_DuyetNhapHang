//
//  AlertManager.swift
//  Fpharmacy
//
//  Created by DungTV1991 on 5/20/21.
//  Copyright © 2021 dangvm2. All rights reserved.
//

import UIKit
import PopupDialog
import RxCocoa
import RxSwift
import FSCalendar

class AlertManager {
    
    static let shared = AlertManager()
    private init(){
        
    }
    
    func alertWithViewController( title:String,
                                  message:String,
                                  titleButton:String,
                                  viewController:UIViewController,
                                  completion : @escaping () -> Void
    ) {
        
        let popup = PopupDialog(title: title,
                                message: message,
                                image: nil,
                                tapGestureDismissal: false,
                                panGestureDismissal: false,
                                hideStatusBar: false
        )
        let buttonOne = CancelButton(title: "OK") {
            completion()
        }

        popup.addButton(buttonOne)
        viewController.present(popup, animated: true, completion: nil)
    }
    
    func alertWithRootViewController( title:String,
                                      message:String,
                                      titleButton:String,
                                      completion: @escaping () -> Void
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: titleButton, style: UIAlertAction.Style.default) {
            UIAlertAction in
            completion()
        }
        alertController.addAction(okAction)
        var keyWindow: UIWindow?
        DispatchQueue.main.async {
            if #available(iOS 13, *) {
                keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            }else {
                keyWindow = UIApplication.shared.keyWindow
            }
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertMultiOption(title: String, message: String, options: String...,viewController:UIViewController,buttonAlignment:NSLayoutConstraint.Axis, completion: @escaping (Int) -> Void) {
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: buttonAlignment,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: false,
                                panGestureDismissal: false,
                                hideStatusBar: false)
        for (index, option) in options.enumerated() {
            let buttonOne = CancelButton(title: option) {
                completion(index)
            }
            popup.addButton(buttonOne)
            
        }
        viewController.present(popup, animated: true, completion: nil)
    }
    
    func showDropDown(
        frame:CGRect,
        viewController:UIViewController,
        data:[String],
        isSearch:Bool
    ){
        let dropDown = DropDownViewController(titleString: data)
        dropDown.frameView = frame
        dropDown.delegate = viewController as? DropDownViewDelegate
        dropDown.isShowSearchView = isSearch
        dropDown.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        dropDown.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        viewController.present(dropDown, animated: true, completion: nil)
    }
    
}

class DropDownCell: BaseTableViewCell {
    
    static let identifier:String = "DropDownCell"
    
    let titleLabel:DefaultUILabel = {
        let label = DefaultUILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol DropDownViewDelegate:class {
    func selectItem(index:Int,title:String)
}

class DropDownViewController : UIViewController {
    
    var isShowSearchView:Bool = false
    
    lazy var tableView:BaseUITableView = {
        let tableView = BaseUITableView()
        return tableView
    }()
    
    lazy var searchBar:UITextField = {
        let searchBar = UITextField()
        searchBar.font = .systemFont(ofSize: 15)
        searchBar.placeholder = "Nhập thông tin cần tìm"
        searchBar.setLeftPaddingPoints(40)
        searchBar.clearButtonMode = .whileEditing
        searchBar.backgroundColor = .white
        return searchBar
    }()
    
    let iconSearch:UIImageView = {
        let image = UIImageView()
        image.tintColor = .lightGray
        return image
    }()
    
    var blurView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    let boderView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    let lineView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    var titleString:[String] = []
    var allString:[String] = []
    var frameView:CGRect!
    var viewController:UIViewController?
    weak var delegate:DropDownViewDelegate?
    
    init(
        titleString:[String]
    ) {
        self.titleString = titleString
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureView()
        self.configureSearchBar()
        self.allString = self.titleString
    }
    
    private func configureSearchBar(){
        self.searchBar.delegate = self
    }
    
    private func configureTableView(){
        self.tableView.register(DropDownCell.self, forCellReuseIdentifier: DropDownCell.identifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    private func configureView(){
        self.view.backgroundColor = .clear
        self.view.addSubview(self.blurView)
        self.blurView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.blurView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.blurView.addSubview(self.searchBar)
        self.blurView.addSubview(self.tableView)
        self.blurView.addSubview(self.boderView)
        self.blurView.addSubview(self.lineView)
        self.searchBar.addSubview(self.iconSearch)
        
        self.searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(self.frameView.origin.y + self.frameView.size.height + 7)
            $0.leading.equalToSuperview().offset(self.frameView.origin.x)
            $0.width.equalTo(self.frameView.size.width)
            if self.isShowSearchView == true {
                $0.height.equalTo(35)
                self.lineView.isHidden = false
                self.iconSearch.isHidden = false
            }else {
                $0.height.equalTo(0)
                self.lineView.isHidden = true
                self.iconSearch.isHidden = true
            }
        }
        
        self.iconSearch.image = UIImage(systemName: "magnifyingglass.circle.fill")
        self.iconSearch.snp.makeConstraints {
            $0.leading.equalTo(self.searchBar.snp.leading).offset(10)
            $0.centerY.equalTo(self.searchBar.snp.centerY)
            $0.height.width.equalTo(25)
        }
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom).offset(1)
            $0.leading.equalToSuperview().offset(self.frameView.origin.x)
            $0.width.equalTo(self.frameView.size.width)
            if self.titleString.count > 10 {
                self.tableView.isScrollEnabled = true
                $0.height.equalTo(350)
            }else {
                self.tableView.isScrollEnabled = false
                $0.height.equalTo(self.titleString.count * 45)
            }
        }
        self.boderView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar).offset(-5)
            $0.bottom.equalTo(self.tableView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(self.searchBar)
        }
        self.blurView.insertSubview(self.boderView, at: 0)
        self.lineView.snp.makeConstraints {
            $0.leading.equalTo(self.searchBar).offset(10)
            $0.trailing.equalTo(self.searchBar).offset(-10)
            $0.top.equalTo(self.searchBar.snp.bottom)
            $0.height.equalTo(0.5)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view != self.tableView {
            self.dismissView()
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DropDownViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell.identifier, for: indexPath) as! DropDownCell
        cell.titleLabel.text = self.titleString[indexPath.row]
        if self.titleString.count != 0 {
            tableView.backgroundView?.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismissView()
        self.delegate?.selectItem(index: indexPath.row, title: self.titleString[indexPath.row])
    }
    
}

extension DropDownViewController : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 0 {
            self.titleString = self.allString
        }else {
            self.filterContentForSearchText(textField.text ?? "")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        let options = String.CompareOptions.caseInsensitive
        let filteredItems = self.allString
            .filter{$0.range(of: searchText, options: options) != nil}
            .sorted{ ($0.hasPrefix(searchText) ? 0 : 1) < ($1.hasPrefix(searchText) ? 0 : 1) }
        self.titleString = filteredItems
    }
}

