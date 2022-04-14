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
                "desc" : desc,
                "image": image
            ]
        }
        
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "Authorization":  "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjNhYjdhMTE0MGYyNTAxM2Q0MjE4ZDJiNzhiZmE3YjIzYTQxZTE4YWMwYjYwYTQ0NWI5YTIwNjAwN2VhMGYxYzFiNmJjYmM0Y2FmMzc4YjJkIn0.eyJhdWQiOiIxIiwianRpIjoiM2FiN2ExMTQwZjI1MDEzZDQyMThkMmI3OGJmYTdiMjNhNDFlMThhYzBiNjBhNDQ1YjlhMjA2MDA3ZWEwZjFjMWI2YmNiYzRjYWYzNzhiMmQiLCJpYXQiOjE2NDkyNDE1MzIsIm5iZiI6MTY0OTI0MTUzMiwiZXhwIjoxNjgwNzc3NTMyLCJzdWIiOiIxOCIsInNjb3BlcyI6W119.J-UjoxAHfpKZbDzZCM5_FmtCqH5x49hi7SX4FNpwmfxHFWkSAYUTatNSyRULf6LgQu2v1qbe_3UWkn1ZyddO1GLbD4YG4zT1Rczoirz2vrEVbax5xlxsiY5kcrvl84TKlqKWUYGeB2RYt62fqtABFVtdYgVgKF2RUeqCrWydHM8DU8mv_XxG0DpylOsMBpQPFGitINLZGG81ZcFJOu6c8CKMlkH1WC37RIda1zpR8R9ytv6tjlGzhKbp9qBAxvnuyjouPDHjlN9ttKQa-Nn3pxK1sIT8teht5bO3lMh7V4bZJqJFvuiJvQbRxNE-V8x2MbuaS9xjcFgql0lpIQkB2frm3Qagsk4VjB0rHubWSx_ujAjcIm2aYM1FqUKJNb_qQWMDd882rCbMFyO4pLovnygjjQEXs4TjoVSvUL9IwKJMTLaskWuN4cF21CPQErQ808ASl9aFdYBlLA-DhUurnizsZ0QqRGXTZVFgop_qLmTfN5E6bF9oJ4r4PyzuUwDgzdzKRjmtKecHSFJzrE1tZf6-NWsjpgTGybmZiDCpyxlrmhSHUQhccAe-aDjqRBsU4Iim-A7KFHA4gjyIifYFcHRxw1KV29qsChUbvLvdVFwvdupnp49zKpUMKiQZsz_lZCdLzo_aQaWcR1WakLDswC72bTOp_qBxul1VxImNKyU"
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
        
        
        
        init(year: String, make: String, model: String, engine: String, plate_number: String, color: String, title: String, desc: String, vin_number: String, id: String ) {
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
                "desc" : desc
            ]
        }
        
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "Authorization":  "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjNhYjdhMTE0MGYyNTAxM2Q0MjE4ZDJiNzhiZmE3YjIzYTQxZTE4YWMwYjYwYTQ0NWI5YTIwNjAwN2VhMGYxYzFiNmJjYmM0Y2FmMzc4YjJkIn0.eyJhdWQiOiIxIiwianRpIjoiM2FiN2ExMTQwZjI1MDEzZDQyMThkMmI3OGJmYTdiMjNhNDFlMThhYzBiNjBhNDQ1YjlhMjA2MDA3ZWEwZjFjMWI2YmNiYzRjYWYzNzhiMmQiLCJpYXQiOjE2NDkyNDE1MzIsIm5iZiI6MTY0OTI0MTUzMiwiZXhwIjoxNjgwNzc3NTMyLCJzdWIiOiIxOCIsInNjb3BlcyI6W119.J-UjoxAHfpKZbDzZCM5_FmtCqH5x49hi7SX4FNpwmfxHFWkSAYUTatNSyRULf6LgQu2v1qbe_3UWkn1ZyddO1GLbD4YG4zT1Rczoirz2vrEVbax5xlxsiY5kcrvl84TKlqKWUYGeB2RYt62fqtABFVtdYgVgKF2RUeqCrWydHM8DU8mv_XxG0DpylOsMBpQPFGitINLZGG81ZcFJOu6c8CKMlkH1WC37RIda1zpR8R9ytv6tjlGzhKbp9qBAxvnuyjouPDHjlN9ttKQa-Nn3pxK1sIT8teht5bO3lMh7V4bZJqJFvuiJvQbRxNE-V8x2MbuaS9xjcFgql0lpIQkB2frm3Qagsk4VjB0rHubWSx_ujAjcIm2aYM1FqUKJNb_qQWMDd882rCbMFyO4pLovnygjjQEXs4TjoVSvUL9IwKJMTLaskWuN4cF21CPQErQ808ASl9aFdYBlLA-DhUurnizsZ0QqRGXTZVFgop_qLmTfN5E6bF9oJ4r4PyzuUwDgzdzKRjmtKecHSFJzrE1tZf6-NWsjpgTGybmZiDCpyxlrmhSHUQhccAe-aDjqRBsU4Iim-A7KFHA4gjyIifYFcHRxw1KV29qsChUbvLvdVFwvdupnp49zKpUMKiQZsz_lZCdLzo_aQaWcR1WakLDswC72bTOp_qBxul1VxImNKyU"
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
        
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "Authorization":  "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjNhYjdhMTE0MGYyNTAxM2Q0MjE4ZDJiNzhiZmE3YjIzYTQxZTE4YWMwYjYwYTQ0NWI5YTIwNjAwN2VhMGYxYzFiNmJjYmM0Y2FmMzc4YjJkIn0.eyJhdWQiOiIxIiwianRpIjoiM2FiN2ExMTQwZjI1MDEzZDQyMThkMmI3OGJmYTdiMjNhNDFlMThhYzBiNjBhNDQ1YjlhMjA2MDA3ZWEwZjFjMWI2YmNiYzRjYWYzNzhiMmQiLCJpYXQiOjE2NDkyNDE1MzIsIm5iZiI6MTY0OTI0MTUzMiwiZXhwIjoxNjgwNzc3NTMyLCJzdWIiOiIxOCIsInNjb3BlcyI6W119.J-UjoxAHfpKZbDzZCM5_FmtCqH5x49hi7SX4FNpwmfxHFWkSAYUTatNSyRULf6LgQu2v1qbe_3UWkn1ZyddO1GLbD4YG4zT1Rczoirz2vrEVbax5xlxsiY5kcrvl84TKlqKWUYGeB2RYt62fqtABFVtdYgVgKF2RUeqCrWydHM8DU8mv_XxG0DpylOsMBpQPFGitINLZGG81ZcFJOu6c8CKMlkH1WC37RIda1zpR8R9ytv6tjlGzhKbp9qBAxvnuyjouPDHjlN9ttKQa-Nn3pxK1sIT8teht5bO3lMh7V4bZJqJFvuiJvQbRxNE-V8x2MbuaS9xjcFgql0lpIQkB2frm3Qagsk4VjB0rHubWSx_ujAjcIm2aYM1FqUKJNb_qQWMDd882rCbMFyO4pLovnygjjQEXs4TjoVSvUL9IwKJMTLaskWuN4cF21CPQErQ808ASl9aFdYBlLA-DhUurnizsZ0QqRGXTZVFgop_qLmTfN5E6bF9oJ4r4PyzuUwDgzdzKRjmtKecHSFJzrE1tZf6-NWsjpgTGybmZiDCpyxlrmhSHUQhccAe-aDjqRBsU4Iim-A7KFHA4gjyIifYFcHRxw1KV29qsChUbvLvdVFwvdupnp49zKpUMKiQZsz_lZCdLzo_aQaWcR1WakLDswC72bTOp_qBxul1VxImNKyU"
            ]
        }
    }
    
    class GarageRequest : RequestModel {
        override var path: String {
            return Constant.ServiceConstant.GARAGE
        }
        override var headers: [String : String] {
            return [
                "Content-Type" : "application/json",
                "Authorization":  "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjNhYjdhMTE0MGYyNTAxM2Q0MjE4ZDJiNzhiZmE3YjIzYTQxZTE4YWMwYjYwYTQ0NWI5YTIwNjAwN2VhMGYxYzFiNmJjYmM0Y2FmMzc4YjJkIn0.eyJhdWQiOiIxIiwianRpIjoiM2FiN2ExMTQwZjI1MDEzZDQyMThkMmI3OGJmYTdiMjNhNDFlMThhYzBiNjBhNDQ1YjlhMjA2MDA3ZWEwZjFjMWI2YmNiYzRjYWYzNzhiMmQiLCJpYXQiOjE2NDkyNDE1MzIsIm5iZiI6MTY0OTI0MTUzMiwiZXhwIjoxNjgwNzc3NTMyLCJzdWIiOiIxOCIsInNjb3BlcyI6W119.J-UjoxAHfpKZbDzZCM5_FmtCqH5x49hi7SX4FNpwmfxHFWkSAYUTatNSyRULf6LgQu2v1qbe_3UWkn1ZyddO1GLbD4YG4zT1Rczoirz2vrEVbax5xlxsiY5kcrvl84TKlqKWUYGeB2RYt62fqtABFVtdYgVgKF2RUeqCrWydHM8DU8mv_XxG0DpylOsMBpQPFGitINLZGG81ZcFJOu6c8CKMlkH1WC37RIda1zpR8R9ytv6tjlGzhKbp9qBAxvnuyjouPDHjlN9ttKQa-Nn3pxK1sIT8teht5bO3lMh7V4bZJqJFvuiJvQbRxNE-V8x2MbuaS9xjcFgql0lpIQkB2frm3Qagsk4VjB0rHubWSx_ujAjcIm2aYM1FqUKJNb_qQWMDd882rCbMFyO4pLovnygjjQEXs4TjoVSvUL9IwKJMTLaskWuN4cF21CPQErQ808ASl9aFdYBlLA-DhUurnizsZ0QqRGXTZVFgop_qLmTfN5E6bF9oJ4r4PyzuUwDgzdzKRjmtKecHSFJzrE1tZf6-NWsjpgTGybmZiDCpyxlrmhSHUQhccAe-aDjqRBsU4Iim-A7KFHA4gjyIifYFcHRxw1KV29qsChUbvLvdVFwvdupnp49zKpUMKiQZsz_lZCdLzo_aQaWcR1WakLDswC72bTOp_qBxul1VxImNKyU"
            ]
        }
    }
}
 
