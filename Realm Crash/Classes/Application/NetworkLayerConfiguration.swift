//
//  NetworkLayerConfiguration.swift
//  Instructor
//
//  Created by Chris Byatt on 18/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

class NetworkLayerConfiguration {

    class func setup() {
        // Backend Configuration
        var apiURL: URL!

        apiURL = URL(string: "https://engine-audi-staging.herokuapp.com")!

        BackendAuth.shared = BackendAuth(defaults: UserDefaults.standard)
        BackendConfiguration.shared = BackendConfiguration(baseURL: apiURL)

        // Network Queue
        NetworkQueue.shared = NetworkQueue()
    }
}
