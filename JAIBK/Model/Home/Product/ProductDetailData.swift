/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct ProductDetailData : Codable {
	let id : String?
	let product_detail : Products?
	let total_rating : Double?
	let rating_avg : Double?
	let review : [Review]?
	let brand_name : String?
	let options : [String]?
	let product_images : [Product_images]?
	let related_product : [Products]?
    let is_review: Bool

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case product_detail = "product_detail"
		case total_rating = "total_rating"
		case rating_avg = "rating_avg"
		case review = "review"
		case brand_name = "brand_name"
		case options = "options"
		case product_images = "product_images"
        case related_product = "related_product"
        case is_review = "is_review"
	}

}
struct Product_images : Codable {
    let product_image_id : String?
    let product_id : String?
    let image : String?
    let sort_order : String?

    enum CodingKeys: String, CodingKey {

        case product_image_id = "product_image_id"
        case product_id = "product_id"
        case image = "image"
        case sort_order = "sort_order"
    }

}

struct Review : Codable {
    let id : String?
    let product_id : String?
    let user_id : String?
    let session_id : String?
    let review : String?
    let rating : String?
    let review_image : String?
    let firstname : String?
    let lastname : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case product_id = "product_id"
        case user_id = "user_id"
        case session_id = "session_id"
        case review = "review"
        case rating = "rating"
        case review_image = "review_image"
        case firstname = "firstname"
        case lastname = "lastname"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
}
