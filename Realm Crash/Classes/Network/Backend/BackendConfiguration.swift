//
//  BackendConfiguration.swift
//  Instructor
//
//  Created by Chris Byatt on 17/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

public final class BackendConfiguration {

    let baseURL: URL
    let socketsURL: URL = URL(string: "http://engine-sockets.midrive.com/")!

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    public static var shared: BackendConfiguration!
}
