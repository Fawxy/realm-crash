//
//  NetworkQueue.swift
//  Instructor
//
//  Created by Chris Byatt on 17/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

public class NetworkQueue {

    public static var shared: NetworkQueue!

    let queue = OperationQueue()

    public init() {}

    public func addOperation(op: Operation) {
        queue.addOperation(op)
    }
}
