//
//  BackendAuth.swift
//  Instructor
//
//  Created by Chris Byatt on 17/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

public final class BackendAuth {

    private let key = "BackendAuthToken"
    private let defaults: UserDefaults

    public static var shared: BackendAuth!

    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }

    public func setToken(token: String) {
        defaults.setValue(token, forKey: key)
    }

    public var token: String? {
        return "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lIjoiMjAxOC0xMC0wNFQxMzozMzozMy42NzVaIiwiZW1haWwiOiJjaHJpcytpbnN0cnVjdG9yYW5kcm9pZEBtaWRyaXZlLmNvbSIsImlkIjoiNjY2MzU2MTEtYTY4Zi00NTc3LWJiNGItNzJmNjU0NzU5OGRiIiwiY29kZSI6InJrRHJHREItNyJ9.yt3EvKwRaMpbsFE-zSwH-oFtxupZhhBi76JrOpft2tU"
    }

    public func deleteToken() {
        defaults.removeObject(forKey: key)
    }
}
