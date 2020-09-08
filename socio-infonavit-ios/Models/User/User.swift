//
//  User.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import Foundation
import Alamofire

struct User { }

// MARK: - Route
enum UserRouter: APIConfiguration {
    case login(parameters: Parameters)
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login:
            return URLEncoding.default
        }
    }
        
    var parameters: Parameters? {
        switch self {
        case .login(let parameters):
            return parameters
        }
    }

    var path: String {
        switch self {
        case .login:
            return "login"
        }
    }

    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: APIManager.shared.host + APIManager.shared.apiVersion + path, method: method)
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        print(urlRequest)
        
        return urlRequest
    }
}

// MARK: - API Calls
extension User {
    
    static func login(with email: String, and password: String, completion: @escaping (Swift.Result<UserResponse, APIError>) -> Void) {
        
        let user: Parameters = [
            "email": email,
            "password": password
        ]
        let parameters: Parameters = [
            "user": user
        ]
        
        
        APIManager.shared.request(urlRequest: UserRouter.login(parameters: parameters)) { (result: Swift.Result<UserResponse, APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print("login error: " + error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
