//
//  HomeRequest.swift
//  JAIBK
//
//  Created by Atta khan on 28/03/2022.
//

import Foundation


class HomeRequest : RequestModel {
    
    
    override var path: String {
        return Constant.ServiceConstant.HOME
    }
    
   
    override var headers: [String : String] {
        return [
            "Content-Type" : "application/json",
            "language_id": "1"
        ]
    }
}
