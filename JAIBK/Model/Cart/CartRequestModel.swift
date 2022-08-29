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
        var type: String
        var quantity: Int
        init(product_id: String, type: String, quantity: Int) {
            self.product_id = product_id
            self.type = type
            self.quantity = quantity
        }
        
        override var path: String {
            return Constant.ServiceConstant.ADD_CART
        }
        
        
        override var body: [String : Any?] {
            return [
                "product_id" : product_id,
                "qty": quantity,
                "type": type
            ]
        }
        
        
        
    }
    class DeleteCartRequest : RequestModel {
        var id: String
        var type: String
        
        init(id: String, type: String) {
            self.id = id
            self.type  = type
        }
        
        override var path: String {
            return Constant.ServiceConstant.DELETE_CART
        }
        
        override var method: RequestHTTPMethod {
            return .post
        }
        override var body: [String : Any?] {
            return [
                "product_id" : id,
                "type": type
            ]
        }
        
    }
    class UpdateCartRequest : RequestModel {
        var product_id: String
        var quantity: Int
        var type: String

        init(product_id: String, quantity: Int, type: String) {
            self.product_id = product_id
            self.quantity = quantity
            self.type  = type
        }
        
        override var path: String {
            return Constant.ServiceConstant.UPDATE_CART
        }
        
        
        override var body: [String : Any?] {
            return [
                "product_id" : product_id,
                "quantity": quantity,
                "type": type
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
        
        
    }
    
}


enum CheckoutRequestModel {
    class CheckoutRequest : RequestModel {
        var first_name: String
        var last_name: String
        var email: String
        var address: String
        var country: String
        var city: String
        var payment_methood: String
        
        init(first_name: String, last_name: String, email: String, address: String, country: String, city: String, payment_methood: String) {
            self.first_name = first_name
            self.last_name = last_name
            self.email = email
            self.address = address
            self.country = country
            self.city = city
            self.payment_methood = payment_methood
        }
        
        override var path: String {
            return Constant.ServiceConstant.ADD_CART
        }
        
        
        override var body: [String : Any?] {
            return [
                "first_name" : first_name,
                "last_name": last_name,
                "email": email,
                "address" : address,
                "country": country,
                "city": city,
                "payment_methood": payment_methood
            ]
        }
        
        
        
    }
    
    
}
