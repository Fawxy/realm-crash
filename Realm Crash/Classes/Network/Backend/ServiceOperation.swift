//
//  ServiceOperation.swift
//  Instructor
//
//  Created by Chris Byatt on 18/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

public class ServiceOperation: NetworkOperation {

    let service: BackendService

    public override init() {
        self.service = BackendService(BackendConfiguration.shared)
        super.init()
    }

    public override func cancel() {
        service.cancel()
        super.cancel()
    }
}
