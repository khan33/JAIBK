//
//  PaymentRequestModel.swift
//  JAIBK
//
//  Created by Atta khan on 06/04/2022.
//

import Foundation

enum PaymentRequestModel {
    class AddPaymentRequest : RequestModel {
        var card_nmbr: String
        var exp_date: String
        
        init(card_nmbr: String, exp_date: String) {
            self.card_nmbr = card_nmbr
            self.exp_date = exp_date
        }
        
        override var path: String {
            return Constant.ServiceConstant.ADD_PAYMENT
        }
        
        
        override var body: [String : Any?] {
            return [
                "card_nmbr" : card_nmbr,
                "exp_date": exp_date,
            ]
        }
        
        
        
    }
    class DeletePaymentRequest : RequestModel {
        var id: String
        
        init(id: String) {
            self.id = id
        }
        
        override var path: String {
            return Constant.ServiceConstant.DELETE_PAYMENT + "/" + id
        }
        
        override var method: RequestHTTPMethod {
            return .post
        }
        
        
    }
    class UpdatePaymentRequest : RequestModel {
        var card_nmbr: String
        var exp_date: String
        var id : String
        
        init(card_nmbr: String, exp_date: String, id: String) {
            self.card_nmbr = card_nmbr
            self.exp_date = exp_date
            self.id = id
        }
        
        override var path: String {
            return Constant.ServiceConstant.UPDATE_PAYMENT + "/" + id
        }
        
        
        override var body: [String : Any?] {
            return [
                "card_nmbr" : card_nmbr,
                "exp_date": exp_date,
                
            ]
        }
        
        
        
    }
    class PaymentRequest : RequestModel {
        override var path: String {
            return Constant.ServiceConstant.PAYMENT
        }
        
        override var method: RequestHTTPMethod {
            return .get
        }
        
        
    }
    
}
