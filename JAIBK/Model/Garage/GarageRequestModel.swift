//
//  GarageRequestModel.swift
//  JAIBK
//
//  Created by Atta khan on 06/04/2022.
//

import Foundation

enum GarageRequestModel {
    
    class AddGarageRequest : RequestModel {
        var year: String
        var make: String
        var model: String
        var engine: String
        var plate_number: String
        var color: String
        var title: String
        var desc: String
        var vin_number: String
        var image: String
        
        
        
        init(year: String, make: String, model: String, engine: String, plate_number: String, color: String, title: String, desc: String, vin_number: String, image: String ) {
            self.year = year
            self.make = make
            self.model = model
            self.engine = engine
            self.plate_number = plate_number
            self.color = color
            self.title = title
            self.desc = desc
            self.vin_number = vin_number
            self.image = image
        }
        
        override var path: String {
            return Constant.ServiceConstant.ADD_GARAGE
        }
        
        
        override var body: [String : Any?] {
            return [
                "year" : year,
                "make": make,
                "model" : model,
                "engine" : engine,
                "plate_number" : plate_number,
                "color" : color,
                "vin_number": vin_number,
                "title": title,
                "description" : desc,
                "image": image
            ]
        }
        
        
        
    }

    class UpdateGarageRequest : RequestModel {
        var year: String
        var make: String
        var model: String
        var engine: String
        var plate_number: String
        var color: String
        var title: String
        var desc: String
        var vin_number: String
        var id: String
        var image: String
        
        
        
        init(year: String, make: String, model: String, engine: String, plate_number: String, color: String, title: String, desc: String, vin_number: String, id: String, image: String ) {
            self.year = year
            self.make = make
            self.model = model
            self.engine = engine
            self.plate_number = plate_number
            self.color = color
            self.title = title
            self.desc = desc
            self.vin_number = vin_number
            self.id = id
            self.image = image
        }
        
        override var path: String {
            return Constant.ServiceConstant.UPDATE_GARAGE + "/" + id
        }
        
        
        override var body: [String : Any?] {
            return [
                "year" : year,
                "make": make,
                "model" : model,
                "engine" : engine,
                "plate_number" : plate_number,
                "color" : color,
                "vin_number": vin_number,
                "title": title,
                "description" : desc,
                "image": image
            ]
        }
        
    }
    
    class DeleteGarageRequest : RequestModel {
        var id: String
        
        init(id: String ) {
            self.id = id
        }
        
        override var path: String {
            return Constant.ServiceConstant.DELETE_GARAGE + "/" + id
        }
        
        
        override var method: RequestHTTPMethod {
            return .post
        }
        
        
    }
    
    class GarageRequest : RequestModel {
        override var path: String {
            return Constant.ServiceConstant.GARAGE
        }
        
    }
}
 
