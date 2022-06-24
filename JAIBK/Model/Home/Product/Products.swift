/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Products : Codable {
    let name: String?
	let product_id : String?
	let vin_number : String?
	let part_number : String?
	let part_number2 : String?
	
	let category_id : String?
	let sub_category_id : String?
	let quantity : String?
	let price : String?
	//let discount_price : String?
	let image : String?
	let added_on : String?
	let seller_id : String?
	let userID : String?
	let userTypeID : String?
	let model_id : String?
	let year_id : String?
	let make_id : String?
	let engine_id : String?
	let manufacturer_id : String?
	let best_seller : String?
	let sort_order : String?
	let model : String?
	let sku : String?
	let stock_status_id : String?
    let height: String?
    let weight: String?
    let width: String?
    let depth: String?
    
	let updated_at : String?
	let created_at : String?
	let descrp_id : String?
	let slug : String?
	let title : String?
	let description : String?
	
	let total_rating : Double?
	let rating_avg : Double?
	let brand_name : String?

	enum CodingKeys: String, CodingKey {
        case name = "name"
		case product_id = "product_id"
		case vin_number = "vin_number"
		case part_number = "part_number"
		case part_number2 = "part_number2"
		case category_id = "category_id"
		case sub_category_id = "sub_category_id"
		case quantity = "quantity"
		case price = "price"
		//case discount_price = "discount_price"
		case image = "image"
		case added_on = "added_on"
		case seller_id = "seller_id"
		case userID = "userID"
		case userTypeID = "userTypeID"
		case model_id = "model_id"
		case year_id = "year_id"
		case make_id = "make_id"
		case engine_id = "engine_id"
		case manufacturer_id = "manufacturer_id"
		case best_seller = "best_seller"
		case sort_order = "sort_order"
		case model = "model"
		case sku = "sku"
		case stock_status_id = "stock_status_id"

		
		case updated_at = "updated_at"
		case created_at = "created_at"
		case descrp_id = "descrp_id"
		case slug = "slug"
		case title = "title"
		case description = "description"
		
		case total_rating = "total_rating"
		case rating_avg = "rating_avg"
		case brand_name = "brand_name"
        
        case height = "height"
        case weight = "weight"
        case width = "width"
        case depth = "depth"
	}

}
