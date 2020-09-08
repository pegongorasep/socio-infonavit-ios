//
//  Benevit.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import Foundation
import Alamofire

struct Benevit { }

// MARK: - Route
enum BenevitRouter: APIConfiguration {
    case getWallets
    case getBenevits
    
    var method: HTTPMethod {
        switch self {
        case .getWallets, .getBenevits:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getWallets, .getBenevits:
            return URLEncoding.default
        }
    }
        
    var parameters: Parameters? {
        switch self {
        case .getWallets, .getBenevits:
            return nil
        }
    }

    var path: String {
        switch self {
        case .getWallets:
            return "member/wallets"
        case .getBenevits:
            return "member/landing_benevits"
        }
    }

    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: APIManager.shared.host + APIManager.shared.apiVersion + path, method: method)
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        if let token = AppDelegate.getToken() {
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }
        print(urlRequest)
        
        return urlRequest
    }
}

// MARK: - API Calls
extension Benevit {
    
    static func getWallets(completion: @escaping (Swift.Result<[WalletResponse], APIError>) -> Void) {
        
        APIManager.shared.request(urlRequest: BenevitRouter.getWallets) { (result: Swift.Result<[WalletResponse], APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print("getWallets error: " + error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    static func getBenevits(completion: @escaping (Swift.Result<BenevitResponse, APIError>) -> Void) {
        
        APIManager.shared.request(urlRequest: BenevitRouter.getBenevits) { (result: Swift.Result<BenevitResponse, APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print("getBenevits error: " + error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
