//
//  DatePickerController.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 16/10/2021.
//

import Foundation
import UIKit
import FSCalendar

protocol DatePickerControllerDelegate:class {
    func chooseDatePicker(dateString:String)
}

class DatePickerController : BaseViewController {
    
    var isMultipleSelection:Bool = false
    weak var delegate:DatePickerControllerDelegate?
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    let parentView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
        return view
    }()
    
    let calendar:FSCalendar = {
        let calendar = FSCalendar()
        calendar.appearance.titleFont = .systemFont(ofSize: 15, weight: .regular)
        calendar.appearance.headerTitleColor = .darkGray
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 17, weight: .semibold)
        calendar.appearance.weekdayFont = .systemFont(ofSize: 15, weight: .regular)
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        self.configureLayout()
        self.configureCalendar()
    }
    
    private func configureCalendar(){
        self.calendar.allowsMultipleSelection = isMultipleSelection
        self.calendar.dataSource = self
        self.calendar.delegate = self
        self.configureLanguage()
    }
    
    private func configureLanguage(){
        let locate = Locale.current.languageCode
        self.calendar.locale = Locale(identifier: locate ?? "vi_VN")
    }
    
    private func configureLayout(){
        self.view.addSubview(self.parentView)
        self.parentView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(355)
        }
        
        self.parentView.addSubview(self.calendar)
        self.calendar.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.trailing.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view != self.parentView {
                self.dismissCalendar()
            }
        }
    }
    
    private func dismissCalendar(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DatePickerController : FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.dismiss(animated: true) {
            self.delegate?.chooseDatePicker(dateString: self.formatter.string(from: date))
        }
    }
}

