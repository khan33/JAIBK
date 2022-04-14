/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct WishlistData : Codable {
	let id : String?
	let user_id : String?
	let session_id : String?
	let product_id : String?
	let created_at : String?
	let updated_at : String?
	let used_with : String?
	let vin_number : String?
	let part_number : String?
	let part_number2 : String?
	let upc : String?
	let weight : String?
	let height : String?
	let depth : String?
	let manufacturer : String?
	let transmission_manual : String?
	let category_id : String?
	let sub_category_id : String?
	let quantity : String?
	let price : String?
	let discount_price : String?
	let image : String?
	let is_show : String?
	let is_featured : String?
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
	let width : String?
	let minimum : String?
	let subtract : String?
	let stock_status_id : String?
	let type_id : String?
	let size_id : String?
	let shape_id : String?
	let gender : String?
	let genral : String?
	let shipping : String?
	let uv_protection : String?
	let show_in_menu : String?
	let length : String?
	let date_available : String?
	let status : String?
	let slug : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user_id = "user_id"
		case session_id = "session_id"
		case product_id = "product_id"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case used_with = "used_with"
		case vin_number = "vin_number"
		case part_number = "part_number"
		case part_number2 = "part_number2"
		case upc = "upc"
		case weight = "weight"
		case height = "height"
		case depth = "depth"
		case manufacturer = "manufacturer"
		case transmission_manual = "transmission_manual"
		case category_id = "category_id"
		case sub_category_id = "sub_category_id"
		case quantity = "quantity"
		case price = "price"
		case discount_price = "discount_price"
		case image = "image"
		case is_show = "is_show"
		case is_featured = "is_featured"
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
		case width = "width"
		case minimum = "minimum"
		case subtract = "subtract"
		case stock_status_id = "stock_status_id"
		case type_id = "type_id"
		case size_id = "size_id"
		case shape_id = "shape_id"
		case gender = "gender"
		case genral = "genral"
		case shipping = "shipping"
		case uv_protection = "uv_protection"
		case show_in_menu = "show_in_menu"
		case length = "length"
		case date_available = "date_available"
		case status = "status"
		case slug = "slug"
	}

}
