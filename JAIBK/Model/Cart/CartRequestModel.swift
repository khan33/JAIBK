//
//  CartRequestModel.swift
//  JAIBK
//
//  Created by Atta khan on 06/04/2022.
//

import Foundation

enum CartRequestModel {
    class AddCartRequest : RequestModel {
        var product_id: String
        init(product_id: String) {
            self.product_id = product_id
        }
        
        override var path: String {
            return Constant.ServiceConstant.ADD_CART
        }
        
        
        override var body: [String : Any?] {
            return [
                "product_id" : product_id
            ]
        }
        
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "language_id": "1"
            ]
        }
    }
    class DeleteCartRequest : RequestModel {
        var id: String
        
        init(id: String) {
            self.id = id
        }
        
        override var path: String {
            return Constant.ServiceConstant.DELETE_CART
        }
        
        override var method: RequestHTTPMethod {
            return .post
        }
        override var body: [String : Any?] {
            return [
                "product_id" : id
            ]
        }
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "language_id": "1"
            ]
        }
    }
    class UpdateCartRequest : RequestModel {
        var product_id: String
        var quantity: String

        init(product_id: String, quantity: String) {
            self.product_id = product_id
            self.quantity = quantity
        }
        
        override var path: String {
            return Constant.ServiceConstant.UPDATE_CART
        }
        
        
        override var body: [String : Any?] {
            return [
                "product_id" : product_id,
                "quantity": quantity
                
            ]
        }
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "language_id": "1"
            ]
        }
    }
    class CartRequest : RequestModel {
        
        
        override var path: String {
            return Constant.ServiceConstant.CART
        }
        
        override var method: RequestHTTPMethod {
            return .get
        }
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "language_id": "1"
            ]
        }
    }
    
}
