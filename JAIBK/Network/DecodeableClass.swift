//
//  DecodeableClass.swift
//  JAIBK
//
//  Created by Atta khan on 28/03/2022.
//

import Foundation
class CodableHelper {
    func decodeArray<T: Decodable>(_ data: Data,completion: @escaping (([T]) -> Void)) {
        let decode = JSONDecoder()
        do {
            
            let model = try decode.decode([T].self, from: data)
            completion(model)
        } catch {
            print(error.localizedDescription)
        }
    }
    func decodeObject<T: Decodable>(_ data: Data, completion: @escaping ((T) -> Void)) {
        let decode = JSONDecoder()
        do {
            let model = try decode.decode(T.self, from: data)
            completion(model)
        } catch {
            print(error.localizedDescription)
        }
    }
}
