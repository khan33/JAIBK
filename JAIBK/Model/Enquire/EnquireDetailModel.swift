//
//  EnquireDetailModel.swift
//  JAIBK
//
//  Created by Atta khan on 06/04/2022.
//

import Foundation
struct EnquireDetailModel : Codable {
    let success : Bool?
    let data : [EnquireDetailData]?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case data = "data"
    }


}
