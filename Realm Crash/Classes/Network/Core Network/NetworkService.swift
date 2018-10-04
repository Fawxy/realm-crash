//
//  NetworkService.swift
//  Instructor
//
//  Created by Chris Byatt on 17/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

class NetworkService {

    private var task: URLSessionDataTask?
    private var successCodes: CountableRange<Int> = 200..<299
    private var failureCodes: CountableRange<Int> = 400..<499

    enum Method: String {
        case get, post, put, patch, delete
    }

    enum QueryType {
        case json, path, body
    }

    func makeRequest(for url: URL, method: Method, query type: QueryType,
                     params: [String: Any]? = nil,
                     bodyParams: Any? = nil,
                     headers: [String: String]? = nil,
                     success: ((Data?) -> Void)? = nil,
                     failure: ((_ data: Data?, _ error: NSError?, _ responseCode: Int) -> Void)? = nil) {

        var mutableRequest = makeQuery(for: url, params: params, bodyParams: bodyParams, type: type)

        mutableRequest.allHTTPHeaderFields = headers
        mutableRequest.httpMethod = method.rawValue

        let session = URLSession.shared

        task = session.dataTask(with: mutableRequest as URLRequest, completionHandler: { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(data, error as NSError?, 0)
                return
            }

            if let error = error {
                // Request failed, might be internet connection issue
                failure?(data, error as NSError, httpResponse.statusCode)
                return
            }

            if self.successCodes.contains(httpResponse.statusCode) {
                print("Request finished with success. Code: \(httpResponse.statusCode)")
                success?(data)
            } else if self.failureCodes.contains(httpResponse.statusCode) {
                print("Request finished with failure. Code: \(httpResponse.statusCode)")
                failure?(data, error as NSError?, httpResponse.statusCode)
            } else {
                print("Request finished with serious failure. Code: \(httpResponse.statusCode)")
                // Server returned response with status code different than
                // expected `successCodes`.
                let info = [
                    NSLocalizedDescriptionKey: "Request failed with code \(httpResponse.statusCode)",
                    NSLocalizedFailureReasonErrorKey: "Wrong handling logic, wrong endpoing mapping or backend bug."
                ]
                let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
                failure?(data, error, httpResponse.statusCode)
            }
        })

        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }

    // MARK: Private
    private func makeQuery(for url: URL, params: [String: Any]?, bodyParams: Any?, type: QueryType) -> URLRequest {
        switch type {
        case .json:
            var mutableRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                            timeoutInterval: 10.0)
            if let params = params {
                mutableRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            }

            return mutableRequest
        case .path:
            var queryItems: [URLQueryItem] = []

            params?.forEach { key, value in
                queryItems.append(URLQueryItem(name: key, value: value as? String))
            }

            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = queryItems

            return URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        case .body:
            var mutableRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                            timeoutInterval: 10.0)

            if let bodyData = bodyParams as? Data {
                mutableRequest.httpBody = bodyData
            } else {
                if let bodyArray = bodyParams as? [[Any]] {
                    do {
                        mutableRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyArray, options: [])
                    } catch {
                        print(error.localizedDescription)
                    }
                } else if let bodyArray = bodyParams as? [[String: Any]] {
                    do {
                        mutableRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyArray, options: [])
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    if let bodyParams = bodyParams {
                    do {
                        mutableRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
                    } catch {
                        print(error.localizedDescription)
                    }
                    }
                }
            }

            return mutableRequest
        }
    }
}
