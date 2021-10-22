//
//  ChiTietDuyetNhapHangEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

struct ChiTietDuyetNhapHangEntity:Decodable {
   
    // MARK: - InfoDuyetNhapHangByIDModel
    struct InfoDuyetNhapHangByIDModel: Codable {
        let infoDuyetNhapHangByID: [InfoDuyetNhapHangByID]?
        let infoDuyetNhapHangByIDHeader: InfoDuyetNhapHangByIDHeader?

        enum CodingKeys: String, CodingKey {
            case infoDuyetNhapHangByID = "Info_DuyetNhapHang_ByID"
            case infoDuyetNhapHangByIDHeader = "Info_DuyetNhapHang_ByID_Header"
        }
    }

    // MARK: - InfoDuyetNhapHangByID
    struct InfoDuyetNhapHangByID: Codable {
        let color: String?
        let dvt: Int?
        let dvtName: String?
        let docEntryNhapHang,
            docentry: Int?
        let itemCode,
            itemName,
            lyDo: String?
        let price,
            quantity,
            reasonCode,
            statusCode: Int?
        let statusName: String?
        let totalPrice: Int?

        enum CodingKeys: String, CodingKey {
            case color = "Color"
            case dvt = "DVT"
            case dvtName = "DVT_Name"
            case docEntryNhapHang = "DocEntry_NhapHang"
            case docentry = "Docentry"
            case itemCode = "ItemCode"
            case itemName = "ItemName"
            case lyDo = "LyDo"
            case price = "Price"
            case quantity = "Quantity"
            case reasonCode = "Reason_code"
            case statusCode = "StatusCode"
            case statusName = "StatusName"
            case totalPrice = "TotalPrice"
        }
    }

    // MARK: - InfoDuyetNhapHangByIDHeader
    struct InfoDuyetNhapHangByIDHeader: Codable {
        let docentry,
            docentryNhapHang: Int?
        let nguoiDuyet,
            nguoiTAO: String?
        let tongTien: Int?

        enum CodingKeys: String, CodingKey {
            case docentry = "Docentry"
            case docentryNhapHang = "Docentry_NhapHang"
            case nguoiDuyet = "NguoiDuyet"
            case nguoiTAO = "NguoiTao"
            case tongTien = "TongTien"
        }
    }
    
    struct UpdateInfoDuyetNhapHangModel: Codable {
        let isErr: Int?
        let msg: String?

        enum CodingKeys: String, CodingKey {
            case isErr = "IsErr"
            case msg = "Msg"
        }
    }

    
}
