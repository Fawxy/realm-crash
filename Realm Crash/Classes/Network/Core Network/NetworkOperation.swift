//
//  NetworkOperation.swift
//  Instructor
//
//  Created by Chris Byatt on 17/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

public class NetworkOperation: Operation {

    private var _isReady: Bool
    public override var isReady: Bool {
        get { return _isReady }
        set { update(change: { self._isReady = newValue }, key: "isReady") }
    }

    private var _isExecuting: Bool
    public override var isExecuting: Bool {
        get { return _isExecuting }
        set { update(change: { self._isExecuting = newValue }, key: "isExecuting") }
    }

    private var _isFinished: Bool
    public override var isFinished: Bool {
        get { return _isFinished }
        set { update(change: { self._isFinished = newValue }, key: "isFinished") }
    }

    private var _isCancelled: Bool
    public override var isCancelled: Bool {
        get { return _isCancelled }
        set { update(change: { self._isCancelled = newValue }, key: "isCancelled") }
    }

    private func update(change: () -> Void, key: String) {
        willChangeValue(forKey: key)
        change()
        didChangeValue(forKey: key)
    }

    override init() {
        _isReady = true
        _isExecuting = false
        _isFinished = false
        _isCancelled = false
        super.init()
        name = "Network Operation"
    }

    public override var isAsynchronous: Bool {
        return true
    }

    public override func start() {
        if self.isExecuting == false {
            self.isReady = false
            self.isExecuting = true
            self.isFinished = false
            self.isCancelled = false
        }
    }

    /// Used only by subclasses. Externally you should use `cancel`.
    func finish() {
        self.isExecuting = false
        self.isFinished = true
    }

    public override func cancel() {
        self.isExecuting = false
        self.isCancelled = true
    }
}
