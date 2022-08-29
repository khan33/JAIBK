//
//  ProductReviewRequestModel.swift
//  JAIBK
//
//  Created by Atta khan on 17/08/2022.
//

import Foundation

enum ProductReviewRequestModel {
    
    class AddReviewRequest : RequestModel {
        var product_id: String
        var rating: String
        var review: String
        var image: String
        
        init(product_id: String, rating: String, review: String, image: String ) {
            self.product_id = product_id
            self.rating = rating
            self.review = review
            self.image = image
        }
        
        override var path: String {
            return Constant.ServiceConstant.ADD_REVIEW
        }
        
        
        override var body: [String : Any?] {
            return [
                "product_id" : product_id,
                "rating": rating,
                "review" : review,
                "image" : image
            ]
        }
        
        
        
    }

    
    class GetReviewRequest : RequestModel {
        override var path: String {
            return Constant.ServiceConstant.GARAGE
        }
        
    }
}
