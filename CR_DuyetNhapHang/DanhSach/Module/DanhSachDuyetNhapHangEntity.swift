//
//  DanhSachDuyetNhapHangEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

struct DanhSachDuyetNhapHangEntity:Decodable {
    
    struct DataShopAndStatusModel: Codable {
        let dataShop: [DataShop]?
        let dataStatus: [DataStatus]?

        enum CodingKeys: String, CodingKey {
            case dataShop = "DataShop"
            case dataStatus = "DataStatus"
        }
    }

    // MARK: - DataShop
    struct DataShop: Codable {
        let shopCode, shopName: String?

        enum CodingKeys: String, CodingKey {
            case shopCode = "ShopCode"
            case shopName = "ShopName"
        }
    }

    // MARK: - DataStatus
    struct DataStatus: Codable {
        let id: Int?
        let name: String?

        enum CodingKeys: String, CodingKey {
            case id = "ID"
            case name = "Name"
        }
    }
    
    struct ListDuyetNhapHangModel: Codable {
        var listDuyetNhapHang: [ListDuyetNhapHang]?

        enum CodingKeys: String, CodingKey {
            case listDuyetNhapHang = "List_DuyetNhapHang"
        }
    }

    // MARK: - ListDuyetNhapHang
    struct ListDuyetNhapHang: Codable {
        let color, content, createBy, createByName: String?
        let createDate: String?
        let docentry, docentryNhapHang: Int?
        var employeeApprove, employeeApproveName, itemName, notifyNew: String?
        let notifyTraoDoi: Int?
        let shopName: String?
        let shopCode:String
        let status: Int?
        let statusName: String?

        enum CodingKeys: String, CodingKey {
            case color = "Color"
            case content = "Content"
            case createBy = "CreateBy"
            case createByName = "CreateBy_Name"
            case createDate = "CreateDate"
            case docentry = "Docentry"
            case docentryNhapHang = "Docentry_NhapHang"
            case employeeApprove = "EmployeeApprove"
            case employeeApproveName = "EmployeeApprove_Name"
            case itemName = "ItemName"
            case notifyNew = "Notify_New"
            case notifyTraoDoi = "Notify_TraoDoi"
            case shopName = "ShopName"
            case shopCode = "ShopCode"
            case status = "Status"
            case statusName = "StatusName"
        }
    }

}
