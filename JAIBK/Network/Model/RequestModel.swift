//
//  RequestModel.swift
//  JAIBK
//
//  Created by Atta khan on 28/03/2022.
//

import Foundation
class RequestModel: NSObject {
    
    // MARK: - properties
    
    var path: String {
        return ""
    }
    
    
    var parameters: [String: Any?] {
        return [:]
    }
    
    
    
    
    var body: [String: Any?] {
        return [:]
    }
    
    
    var method: RequestHTTPMethod {
        return body.isEmpty ? RequestHTTPMethod.get : RequestHTTPMethod.post
    }
    

    var isLoggingEnabled: ( Bool, Bool ) {
        return (true, true)
    }
    
    
}
enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


// MARK: - Public Functions

extension RequestModel {
    
    var headers: [String : String] {
        var headers: [String: String] = [ "Content-Type": "application/json",
                                          "language_id": "1" ]
        
        if let token = UserDefaults.standard.string(forKey: "token"), token != "" {
            headers["Authorization"] = "Bearer \(token)"
        } else {
            headers["session_id"] = UserDefaults.standard.string(forKey: "session_id")
        }
        return headers
        
    }
    
    func urlRequest() -> URLRequest {
        var endPoint = ServiceManager.shared.baseURL.appending(path)

        for parameter in parameters {

            if let value = parameter.value as? String {
                print(value)
                endPoint.append("?\(parameter.key)=\(value)")
            }
        }

        var request: URLRequest = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = method.rawValue

        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
            
        }

        
        if method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch let error {
                print(error)
            }
        }
        return request
        
    }
    
}


