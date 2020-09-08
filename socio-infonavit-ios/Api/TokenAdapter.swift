//
//  TokenAdapter.swift
//  socio-infonavit-ios
//
//  Created by Pedro Antonio Góngora Sepúlveda on 07/09/20.
//  Copyright © 2020 Nextia. All rights reserved.
//

import Foundation
import Alamofire

public class TokenAdapter: RequestAdapter {
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + self.accessToken, forHTTPHeaderField: "Authorization")
        
        completion(.success(urlRequest))
    }
    
    private let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}

