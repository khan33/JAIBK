//
//  ResponseModel.swift
//  JAIBK
//
//  Created by Atta khan on 28/03/2022.
//

import UIKit

struct ResponseModel<T: Codable>: Codable {
    
    // MARK: - Properties
    var targetUrl: String?
    var success: Bool
    var unAuthorizedRequest: String?
    var abp: Bool = false
    
    
    var isSuccess: Bool
    var message: String
    var error: ErrorModel {
        return ErrorModel(message)
    }
    var rawData: Data?
    var data: T?
    var result: T?
    var json: String? {
        guard let rawData = rawData else { return nil }
        return String(data: rawData, encoding: String.Encoding.utf8)
    }
    var request: RequestModel?

    init() {
        self.isSuccess = false
        self.message = ""
        self.success = false
    }
    
    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.success)) ?? false
        isSuccess = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.isSuccess)) ?? false
        message = (try? keyedContainer.decode(String.self, forKey: CodingKeys.message)) ?? ""
        data = try? keyedContainer.decode(T.self, forKey: CodingKeys.data)
        result = try? keyedContainer.decode(T.self, forKey: CodingKeys.result)
        abp = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.success)) ?? false
    }
}

// MARK: - Private Functions
extension ResponseModel {

    private enum CodingKeys: String, CodingKey {
        case isSuccess
        case message
        case data
        case result
        case targetUrl
        case success
        case unAuthorizedRequest
        case abp = "__abp"
    }
}
