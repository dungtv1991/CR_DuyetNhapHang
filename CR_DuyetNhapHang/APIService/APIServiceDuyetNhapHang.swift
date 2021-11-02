//
//  APIServiceDuyetNhapHang.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 14/10/2021.
//

import Foundation
import Alamofire

enum APIRouterDuyetNhapHang: URLRequestConvertible {
    case getListDuyetNhapHang(
        soPhieu : Int,
        fromDate : String,
        toDate : String,
        User : String,
        shopCode : String,
        isPM : Int,
        status : String
    )
    case getDataShopAndDataStatus(user:String)
    case getInfoDuyetNhapHangByID(
        soPhieu:Int
    )
    case updateInfoDuyetNhapHang (
        soPhieu : Int,
        status : Int,
        dataDetail: String,
        user : String
    )
    
    private var url:String {
        switch self {
        case    .getListDuyetNhapHang,
                .getDataShopAndDataStatus,
                .getInfoDuyetNhapHangByID,
                .updateInfoDuyetNhapHang:
            return URLs.main
        }
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case    .getListDuyetNhapHang,
                .getDataShopAndDataStatus,
                .getInfoDuyetNhapHangByID,
                .updateInfoDuyetNhapHang:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getListDuyetNhapHang :
            return "GetList_DuyetNhapHang"
        case .getDataShopAndDataStatus :
            return "Get_MasterData_DuyetNhapHang"
        case .getInfoDuyetNhapHangByID :
            return "GetInfo_DuyetNhapHang_ByID"
        case .updateInfoDuyetNhapHang:
            return "UpdateInfo_DuyetNhapHang"
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        let headers:HTTPHeaders = ["Content-Type": "application/json"]
        switch self {
        case    .getListDuyetNhapHang,
                .getDataShopAndDataStatus,
                .getInfoDuyetNhapHangByID,
                .updateInfoDuyetNhapHang:
            break
        }
        return headers
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getDataShopAndDataStatus(let user):
            return [
                "User":user
            ]
        case .getListDuyetNhapHang(
            soPhieu: let soPhieu,
            fromDate: let fromDate,
            toDate: let toDate,
            User: let User,
            shopCode: let shopCode,
            isPM: let isPM,
            status: let status):
            return [
                "SoPhieu" : soPhieu,
                "FromDate" : fromDate,
                "ToDate" : toDate,
                "User" : User,
                "ShopCode" : shopCode,
                "IsPM" : isPM,
                "Status" : status
            ]
        case .getInfoDuyetNhapHangByID(soPhieu: let soPhieu):
            return [
                "SoPhieu":soPhieu
            ]
        case .updateInfoDuyetNhapHang(
            soPhieu: let soPhieu,
            status: let status,
            dataDetail: let dataDetail,
            user: let user):
            return [
                "SoPhieu": soPhieu,
                "Status": status,
                "User" : user,
                "Data_Detail":dataDetail
            ]
        }
        
    }

    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
        
        let url = try self.url.asURL()

        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.httpMethod = self.method.rawValue

        self.headers.forEach { (header) in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.name)
        }
        
        if let parameters = self.parameters {
            do {
                if urlRequest.httpMethod == "GET" {
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                }else {
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
                }
            } catch {
                print("Encoding Parameters fail")
            }
        }
        
        return urlRequest
    }
    
}

class APIRequestDuyetNhapHang {
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func request<T: Decodable>(_ apiRouter: APIRouterDuyetNhapHang,_ returnType: T.Type, completion: @escaping (Result<T,APIErrorType>) -> Void) {
        if !isConnectedToInternet() {
            AlertManager.shared.alertWithRootViewController(title: "", message: "Không có kết nối internet", titleButton: "OK") {
                
            }
            return
        }
        
        AF.request(apiRouter).response { (response) in
        
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(APIErrorType.vpnError))
                return
            }
            switch statusCode {
            case 0: completion(.failure(APIErrorType.vpnError))
                return
            case 400: completion(.failure(APIErrorType.code400))
                return
            case 401: completion(.failure(APIErrorType.code401))
                return
            case 403: completion(.failure(APIErrorType.code403))
                return
            case 404: completion(.failure(APIErrorType.code404))
                return
            case 405: completion(.failure(APIErrorType.code405))
                return
            case 503: completion(.failure(APIErrorType.code503))
                return
            default:
                break
            }
            
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let stringJSON = json as? String {
                        let dataJSON = Data(stringJSON.replacingOccurrences(of: "\\", with: "").utf8)
                        let JSON = try JSONDecoder().decode(T.self, from: dataJSON)
                        completion(.success(JSON))
                    }else {
                        let JSON = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(JSON))
                    }
                }catch {
                    completion(.failure(APIErrorType.invalidPaserData))
                }
            case .failure(let error) :
                if error._code == NSURLErrorTimedOut {
                    completion(.failure(APIErrorType.requestTimeout))
                    return
                }
                completion(.failure(APIErrorType
                                        .defaultError(
                                            code: statusCode,
                                            message: error.localizedDescription)))
            }
        }
    }
    
    
}

