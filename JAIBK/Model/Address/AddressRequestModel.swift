//
//  AddressRequestModel.swift
//  JAIBK
//
//  Created by Atta khan on 06/04/2022.
//

import Foundation

enum AddressRequestModel {
    class AddAddressRequest : RequestModel {
        var first_name: String
        var last_name: String
        var street_address: String
        var country: String
        var city: String
        var phone_no: String

        init(first_name: String, last_name: String, street_address: String, country: String, city: String, phone_no: String) {
            self.first_name = first_name
            self.last_name = last_name
            self.street_address = street_address
            self.country = country
            self.city = city
            self.phone_no = phone_no
        }
        
        override var path: String {
            return Constant.ServiceConstant.ADD_ADDRESS
        }
        
        
        override var body: [String : Any?] {
            return [
                "first_name" : first_name,
                "last_name": last_name,
                "street_address" : street_address,
                "country": country,
                "city" : city,
                "phone_no": phone_no
            ]
        }
        
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "language_id": "1"
            ]
        }
    }
    class DeleteAddressRequest : RequestModel {
        var id: String
        
        init(id: String) {
            self.id = id
        }
        
        override var path: String {
            return Constant.ServiceConstant.DELETE_ADDRESS + "/" + id
        }
        
        override var method: RequestHTTPMethod {
            return .post
        }
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "language_id": "1"
            ]
        }
    }
    class UpdateAddressRequest : RequestModel {
        var first_name: String
        var last_name: String
        var street_address: String
        var country: String
        var city: String
        var phone_no: String
        var id: String

        init(first_name: String, last_name: String, street_address: String, country: String, city: String, phone_no: String, id: String) {
            self.first_name = first_name
            self.last_name = last_name
            self.street_address = street_address
            self.country = country
            self.city = city
            self.phone_no = phone_no
            self.id = id
        }
        
        override var path: String {
            return Constant.ServiceConstant.UPDATE_ADDRESS + "/" + id
        }
        
        
        override var body: [String : Any?] {
            return [
                "first_name" : first_name,
                "last_name": last_name,
                "street_address" : street_address,
                "country": country,
                "city" : city,
                "phone_no": phone_no
                
            ]
        }
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "language_id": "1"
            ]
        }
    }
    class AddressRequest : RequestModel {
        
        
        override var path: String {
            return Constant.ServiceConstant.ADDRESS
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
    class CountryRequest : RequestModel {
        
        
        override var path: String {
            return Constant.ServiceConstant.GET_ALL_COUNTRY
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
    
    class CityRequest : RequestModel {
        var country_code: String
        
        init(country_code: String) {
            self.country_code = country_code
        }
        
        override var path: String {
            return Constant.ServiceConstant.GET_CITY + "/" + country_code
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
