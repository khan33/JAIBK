/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CategoryData : Codable {
	let id : String?
	let image : String?
	let banner_image : String?
	let parent_id : String?
	let top : String?
	let column : String?
	let sort_order : String?
	let status : String?
	let date_added : String?
	let date_modified : String?
	let category_id : String?
	let title : String?
	let slug : String?
	let description : String?
    let check_sub_category: Bool?
	

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case image = "image"
		case banner_image = "banner_image"
		case parent_id = "parent_id"
		case top = "top"
		case column = "column"
		case sort_order = "sort_order"
		case status = "status"
		case date_added = "date_added"
		case date_modified = "date_modified"
		case category_id = "category_id"
		case title = "title"
		case slug = "slug"
		case description = "description"
        case check_sub_category = "check_sub_category"
	}
}
