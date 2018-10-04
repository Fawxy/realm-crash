//
//  LessonTrackingOperation.swift
//  Instructor
//
//  Created by Chris Byatt on 24/10/2017.
//Copyright © 2017 Midrive. All rights reserved.
//

import Foundation

public class CreateLessonReportOperation: ServiceOperation {

    private let request: CreateLessonReportRequest

    public var success: ((LessonReportItem) -> Void)?
    public var failure: ((NSError) -> Void)?

    public init(lessonId: String) {
        request = CreateLessonReportRequest(lessonId: lessonId)
        super.init()
    }

    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }

    private func handleSuccess(_ response: AnyObject?) {
        do {
            let item = try LessonReportResponseMapper.process(response)
            self.success?(item)
            self.finish()
        } catch {
            let info = [NSLocalizedDescriptionKey: "Can't parse response. Please report a bug."]
            let parseError = NSError(domain: String(describing: self), code: 0, userInfo: info)
            handleFailure(parseError)
        }
    }

    private func handleFailure(_ error: NSError) {
        self.failure?(error)
        self.finish()
    }
}
