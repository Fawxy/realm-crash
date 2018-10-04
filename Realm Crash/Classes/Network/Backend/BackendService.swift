//
//  BackendService.swift
//  Instructor
//
//  Created by Chris Byatt on 17/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

public let DidPerformUnauthorizedOperation = "DidPerformUnauthorizedOperation"

class BackendService {

    private let conf: BackendConfiguration
    private let service = NetworkService()

    init(_ conf: BackendConfiguration) {
        self.conf = conf
    }

    func request(_ request: BackendAPIRequest,
                 success: ((AnyObject?) -> Void)? = nil,
                 failure: ((NSError) -> Void)? = nil) {

        let url = conf.baseURL.appendingPathComponent(request.endpoint)

        var headers = request.headers
        // Set authentication token if available.
        if let token = BackendAuth.shared.token {
            headers?["Authorization"] = token
        }

        service.makeRequest(for: url, method: request.method, query: request.query, params: request.parameters, bodyParams: request.bodyParams, headers: headers, success: { data in
            var json: AnyObject?
            if let data = data {
                json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as AnyObject
            }
            success?(json)

            }, failure: { data, error, statusCode in
                if statusCode == 401 {
                    // Operation not authorized
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: DidPerformUnauthorizedOperation), object: nil)
                    let info = [
                        NSLocalizedDescriptionKey: "Incorrect email or password.",
                        NSLocalizedFailureReasonErrorKey: "Unauthorized"
                    ]
                    let error = NSError(domain: "Code: \(statusCode)", code: statusCode, userInfo: info)
                    failure?(error)
                    return
                }

                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as AnyObject
                    var message = "Something went wrong."
                    if let errorMessage = json?["errorMessage"] as? String {
                        message = errorMessage
                    } else if let errorMessage = json?["message"] as? String {
                        message = errorMessage
                    } else if let errorMessage = json?["error"] as? String {
                        message = errorMessage
                    }

                    let info = [
                        NSLocalizedDescriptionKey: message,
                        NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                    ]
                    let error = NSError(domain: "Code: \(statusCode)", code: statusCode, userInfo: info)
                    failure?(error)
                } else {
                    failure?(error ?? NSError(domain: "Code: \(statusCode)", code: statusCode, userInfo: nil))
                }
        })
    }

    func cancel() {
        service.cancel()
    }
}
