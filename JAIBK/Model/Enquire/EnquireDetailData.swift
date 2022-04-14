/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct EnquireDetailData : Codable {
	let id : String?
	let product_id : String?
	let image : String?
	let price : String?
	let brand_name : String?
	let user_id : String?
	let session_id : String?
	let seller_id : String?
	let product_name : String?
	let first_name : String?
	let last_name : String?
	let email : String?
	let phone : String?
	let message : String?
	let reply : String?
	let status : String?
	let added_on : String?
	let quantity : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case product_id = "product_id"
		case image = "image"
		case price = "price"
		case brand_name = "brand_name"
		case user_id = "user_id"
		case session_id = "session_id"
		case seller_id = "seller_id"
		case product_name = "product_name"
		case first_name = "first_name"
		case last_name = "last_name"
		case email = "email"
		case phone = "phone"
		case message = "message"
		case reply = "reply"
		case status = "status"
		case added_on = "added_on"
		case quantity = "quantity"
	}


}
