//
//  SearchRequestModel.swift
//  JAIBK
//
//  Created by Atta khan on 16/08/2022.
//

import Foundation
enum SearchRequestModel {
    class SearchByCarRequest : RequestModel {
        var year: String
        var make: String
        var engine: String
        var model: String
        
        init(year: String, make: String, engine: String, model: String) {
            self.year = year
            self.make = make
            self.engine = engine
            self.model = model
        }
        
        override var path: String {
            return Constant.ServiceConstant.SEARCH_BY_CAR
        }
        
        
        override var body: [String : Any?] {
            return [
                "year" : year,
                "make": make,
                "engine": engine,
                "model": model,
            ]
        }
        
    }
    
    
    class SearchByVIN: RequestModel {
        var vin_number: String
        
        init(vin_number: String) {
            self.vin_number = vin_number
        }
        
        override var path: String {
            return Constant.ServiceConstant.SEARCH_BY_VIN + "?vin_number=\(vin_number)"
        }
    }
}
