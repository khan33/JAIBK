//
//  ErrorModel.swift
//  JAIBK
//
//  Created by Atta khan on 28/03/2022.
//

import UIKit

class ErrorModel: Error {
    
    // MARK: - Properties
    
    var messageKey: String
    var message: String {
        return messageKey.localizedLowercase
    }
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: - Public Function

extension ErrorModel {
    
    class func generalError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }
    
}

enum ErrorKey: String {
    case general = "Error_general"
    case parsing = "Error_parsing"
}

