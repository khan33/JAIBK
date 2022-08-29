/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct User : Codable {
	let firstname : String?
	let lastname : String?
	let email : String?
	let company : String?
	let role : String?
	let verificationcode : String?
	let image : String?
	let usr_type : String?
	let updated_at : String?
	let created_at : String?
	let id : Int?
    var userName: String {
        return (firstname ?? "") + " " + (lastname ?? "")
    }
	enum CodingKeys: String, CodingKey {

		case firstname = "firstname"
		case lastname = "lastname"
		case email = "email"
		case company = "company"
		case role = "role"
		case verificationcode = "verificationcode"
		case image = "image"
		case usr_type = "usr_type"
		case updated_at = "updated_at"
		case created_at = "created_at"
		case id = "id"
	}

}
