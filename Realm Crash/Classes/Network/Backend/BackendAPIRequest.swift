//
//  BackendAPIRequest.swift
//  Instructor
//
//  Created by Chris Byatt on 17/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

protocol BackendAPIRequest {
    var endpoint: String { get }
    var method: NetworkService.Method { get }
    var query: NetworkService.QueryType { get }
    var parameters: [String: Any]? { get }
    var bodyParams: Any? { get }
    var headers: [String: String]? { get }
}

extension BackendAPIRequest {
    func defaultJSONHeaders() -> [String: String] {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        return [
            "Content-Type": "application/json",
            "Operating-System": "iOS",
            "App-Version": version,
            "App-Name": "Instructor"
        ]
    }
}
