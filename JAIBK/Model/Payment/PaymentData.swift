/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct PaymentData : Codable {
	let id : String?
	let user_id : String?
    let order_id: String?
	let card_numbr : String?
	let expiry_date : String?
	let added_on : String?
    let name_on_card: String?
    let cvv: String?
    let stripe_payment_id: String?
    let stripe_status: String?
    

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case user_id = "user_id"
		case card_numbr = "card_numbr"
		case expiry_date = "expiry_date"
		case added_on = "added_on"
        case order_id = "order_id"
        case name_on_card = "name_on_card"
        case cvv = "cvv"
        case stripe_payment_id = "stripe_payment_id"
        case stripe_status = "stripe_status"
	}

}
