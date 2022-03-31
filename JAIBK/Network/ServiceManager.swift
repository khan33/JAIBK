//
//  ServiceManager.swift
//  JAIBK
//
//  Created by Atta khan on 28/03/2022.
//

import Foundation


class ServiceManager: NSObject {
    // MARK: - Properties
    static let shared: ServiceManager = ServiceManager()
    var baseURL: String = "https://jaibk.gcc-demo.com/api/"
    

}


// MARK: - Public Functions
extension ServiceManager {

    func sendRequest<T: Codable>(request: RequestModel, model: T.Type, completion: @escaping (Swift.Result<T, Error>) -> Void) where T: Codable {
        if request.isLoggingEnabled.0 {
            LogManager.req(request)
        }
        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            do {
                guard response != nil else {
                    completion(Result.failure(error as! Error))
                    return
                }
                
    //            guard let httpResponse = response as? HTTPURLResponse,
    //                  (200...299).contains(httpResponse.statusCode) else {
    //                      print(response)
    //                //completion(Result.failure(response))
    //                return
    //            }
                
                
                
                guard let data = data, let responseString = String.init(data: data, encoding: String.Encoding.utf8) else {
                    let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                    LogManager.err(error)
                    completion(Result.failure(error))
                    return
                }
                let value = responseString.replacingOccurrences(of: "\"", with: "")
                print("================Request Respnse ========================")
                print(value)
                print("========================================")
                let result = try JSONDecoder().decode(model.self, from: data)
                completion(Result.success(result))
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
enum AppRepsone {
    case error(CZError)
}
enum CZError {
    case cannotDecode // Handle ComminDate
    case noInternet // ---
    case error(String) // Error.Description
    case tokenExpire // 401
    case validateInputs // 412
    case badUrl // 400
    case forbiden // 403
    case internalServerError // 500
    case cannotDecodeItem(String)
    case timeOut
    var description: String {
        switch self {
        case let .cannotDecodeItem(key):
            return "cannotDecode + \(key)"
        case .cannotDecode:
            return "cannotDecode"
        case .noInternet:
            return "noInternet"
        case let .error(err):
            return err
        case .tokenExpire:
            return "tokenExpire"
        case .validateInputs:
            return "validateInputs"
        case .badUrl:
            return "badUrl"
        case .forbiden:
            return "forbiden"
        case .internalServerError:
            return "internalServerError"
        case .timeOut:
            return "timeOut"
        }
    }
}
