//
//  LessonTrackingRequest.swift
//  Instructor
//
//  Created by Chris Byatt on 24/10/2017.
//Copyright © 2017 Midrive. All rights reserved.
//

import Foundation

class CreateLessonReportRequest: BackendAPIRequest {

    // Create private variables for parameters required for request
    private let lessonId: String

    init(lessonId: String) {
        self.lessonId = lessonId
    }

    var endpoint: String {
        return "/lesson/reports"
    }

    var method: NetworkService.Method {
        return .post
    }

    var query: NetworkService.QueryType {
        return .json
    }

    var parameters: [String: Any]? {
        return [
            "lesson_id": lessonId
        ]
    }

    var bodyParams: Any? {
        return nil
    }

    var headers: [String: String]? {
        return defaultJSONHeaders()
    }
}
