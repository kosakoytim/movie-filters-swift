//
//  Network.swift
//  Movie Filter Swift
//
//  Created by Timothy Kosakoy on 14/03/21.
//  Copyright © 2021 Re:Utopia. All rights reserved.
//

import Foundation

struct Network {
    enum BaseURL {
        case GHIBLI_API
        
        var value : String {
            switch self {
            case .GHIBLI_API:
                return "https://ghibliapi.herokuapp.com"
            }
        }
    }
    
    enum RequestType : String {
        case GET
        
        var value: String {
            switch self {
            case .GET:
                return "GET"
            }
        }
    }
    
    enum Response<Value: Any> {
        case SUCCESS(Any)
        case FAILURE(Any)
    }
    
    func fetch(
        requestURL: URL,
        requestType: RequestType,
        parameter:[String:AnyObject]? = nil,
        completion:@escaping (Response<Any>) -> ()
    ){
        var urlRequest = URLRequest.init(url: requestURL)
        urlRequest.timeoutInterval = 60
        urlRequest.httpMethod = requestType.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        if let params = parameter {
            do{
                let parameterData = try JSONSerialization.data(withJSONObject:params, options:.prettyPrinted)
                urlRequest.httpBody = parameterData
            }catch{
                completion(.FAILURE(error))
            }
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let objError = error{
                completion(.FAILURE(objError))
            }
            
            if let objData = data,let objURLResponse = response as? HTTPURLResponse{
                if objURLResponse.statusCode == 200{
                    completion(.SUCCESS(objData))
                } else {
                    completion(.SUCCESS(objData))
                }
            }
        }.resume()
    }
    
    
}
