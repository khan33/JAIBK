//
//  EnquireRequestModel.swift
//  JAIBK
//
//  Created by Atta khan on 06/04/2022.
//

import Foundation

enum EnquireRequestModel {

    class AddEnquireRequest : RequestModel {
        var id: String
        var name: String
        var quantity: String
        var first_name: String
        var last_name: String
        var email: String
        var phone: String
        var message: String
        
        
        
        init(id: String, name: String, quantity: String, first_name: String, last_name: String, email: String, phone: String, message: String ) {
            self.id = id
            self.name = name
            self.quantity = quantity
            self.first_name = first_name
            self.last_name = last_name
            self.email = email
            self.phone = phone
            self.message = message
        }
        
        override var path: String {
            return Constant.ServiceConstant.ADD_ENQUIRE
        }
        
        
        override var body: [String : Any?] {
            return [
                "product_id" : id,
                "product_name": name,
                "quantity" : quantity,
                "first_name" : first_name,
                "last_name" : last_name,
                "email" : email,
                "phone": phone,
                "message" : message
            ]
        }
        
        
        
    }


    class EnquireRequest : RequestModel {
        
        override var path: String {
            return Constant.ServiceConstant.ENQUIRE
        }
        
        
        
    }

    
    class EnquireDetailRequest : RequestModel {
        var id: String
        init(id: String) {
            self.id = id
        }
        override var path: String {
            return Constant.ServiceConstant.ENQUIRE_DETAIL + "/" + id
        }
        
        
        
    }
}
