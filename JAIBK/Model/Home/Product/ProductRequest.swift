//
//  ProductRequest.swift
//  JAIBK
//
//  Created by Atta khan on 11/05/2022.
//

import Foundation


class ProductDetailRequest : RequestModel {
    var id: String
    init(id: String) {
        self.id = id
    }
    
    override var path: String {
        return Constant.ServiceConstant.PRODUCT_DETAIL + "?id=" + id
    }
    
   
    
}
