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
}

class SessionRequest: RequestModel {
    override var path: String {
        return Constant.ServiceConstant.GET_SESSION_ID
    }
}

