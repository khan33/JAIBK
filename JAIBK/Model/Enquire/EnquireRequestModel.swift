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
        
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "language_id": "1"
            ]
        }
    }


    class EnquireRequest : RequestModel {
        
        override var path: String {
            return Constant.ServiceConstant.ENQUIRE
        }
        
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "Authorization":  "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjNhYjdhMTE0MGYyNTAxM2Q0MjE4ZDJiNzhiZmE3YjIzYTQxZTE4YWMwYjYwYTQ0NWI5YTIwNjAwN2VhMGYxYzFiNmJjYmM0Y2FmMzc4YjJkIn0.eyJhdWQiOiIxIiwianRpIjoiM2FiN2ExMTQwZjI1MDEzZDQyMThkMmI3OGJmYTdiMjNhNDFlMThhYzBiNjBhNDQ1YjlhMjA2MDA3ZWEwZjFjMWI2YmNiYzRjYWYzNzhiMmQiLCJpYXQiOjE2NDkyNDE1MzIsIm5iZiI6MTY0OTI0MTUzMiwiZXhwIjoxNjgwNzc3NTMyLCJzdWIiOiIxOCIsInNjb3BlcyI6W119.J-UjoxAHfpKZbDzZCM5_FmtCqH5x49hi7SX4FNpwmfxHFWkSAYUTatNSyRULf6LgQu2v1qbe_3UWkn1ZyddO1GLbD4YG4zT1Rczoirz2vrEVbax5xlxsiY5kcrvl84TKlqKWUYGeB2RYt62fqtABFVtdYgVgKF2RUeqCrWydHM8DU8mv_XxG0DpylOsMBpQPFGitINLZGG81ZcFJOu6c8CKMlkH1WC37RIda1zpR8R9ytv6tjlGzhKbp9qBAxvnuyjouPDHjlN9ttKQa-Nn3pxK1sIT8teht5bO3lMh7V4bZJqJFvuiJvQbRxNE-V8x2MbuaS9xjcFgql0lpIQkB2frm3Qagsk4VjB0rHubWSx_ujAjcIm2aYM1FqUKJNb_qQWMDd882rCbMFyO4pLovnygjjQEXs4TjoVSvUL9IwKJMTLaskWuN4cF21CPQErQ808ASl9aFdYBlLA-DhUurnizsZ0QqRGXTZVFgop_qLmTfN5E6bF9oJ4r4PyzuUwDgzdzKRjmtKecHSFJzrE1tZf6-NWsjpgTGybmZiDCpyxlrmhSHUQhccAe-aDjqRBsU4Iim-A7KFHA4gjyIifYFcHRxw1KV29qsChUbvLvdVFwvdupnp49zKpUMKiQZsz_lZCdLzo_aQaWcR1WakLDswC72bTOp_qBxul1VxImNKyU"
            ]
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
        
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "language_id": "1"
            ]
        }
    }
}
