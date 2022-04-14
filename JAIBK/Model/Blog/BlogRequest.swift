//
//  BlogRequest.swift
//  JAIBK
//
//  Created by Atta khan on 05/04/2022.
//

import Foundation

class BlogRequest : RequestModel {
    
    
    override var path: String {
        return Constant.ServiceConstant.BLOG
    }
    override var headers: [String : String] {
        return [
            "Content-Type" : "application/json",
            "language_id": "1"
        ]
    }
}

class BlogDetailRequest : RequestModel {
    var id: String
    init(id: String) {
        self.id = id
    }
    
    override var path: String {
        return Constant.ServiceConstant.BLOG_DETAIL + "/" + id
    }
    override var headers: [String : String] {
        return [
            "Content-Type" : "application/json",
            "language_id": "1"
        ]
    }
}
