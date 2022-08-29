/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AddressData : Codable {
	let id : String?
	let user_id : String?
	let session_id : String?
	let first_name : String?
	let last_name : String?
	let street_address : String?
	let country : String?
	let city : String?
	let phone_no : String?
	let address : String?
	let status : String?
	let added_on : String?
	let country_name : String?
	let city_name : String?
    
    var fullName: String {
        return (first_name ?? "") + " " + (last_name ?? "")
    }
    
    var fullAddress: String {
        return (address ?? "") + ", " + (city_name ?? "") + ", " + (country_name ?? "")
    }

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user_id = "user_id"
		case session_id = "session_id"
		case first_name = "first_name"
		case last_name = "last_name"
		case street_address = "street_address"
		case country = "country"
		case city = "city"
		case phone_no = "phone_no"
		case address = "address"
		case status = "status"
		case added_on = "added_on"
		case country_name = "country_name"
		case city_name = "city_name"
	}
}
