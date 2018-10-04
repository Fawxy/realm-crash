//
//  LessonReportItem.swift
//  Instructor
//
//  Created by Chris Byatt on 26/10/2017.
//  Copyright © 2017 Midrive. All rights reserved.
//

import Foundation
import RealmSwift

struct LessonTrackingCategory {
    static let anticipationAndPlanning: (apiName: String, displayName: String) = ("anticipation_and_planning", "Anticipation and Planning")

    static let allValues = [anticipationAndPlanning]

    static func getDisplayName(for apiName: String) -> String {
        return LessonTrackingCategory.allValues.filter({$0.apiName == apiName}).first!.displayName
    }
}

public class LessonReportItem: Object, ParsedItem {

    @objc dynamic var id: String!

    @objc dynamic var lessonId: String!

    let outstandingTrackingSubcategories = List<TrackingSubcategoryItem>()
    let trackingCategoryProgress = List<TrackingCategoryProgressItem>()

    override public class func primaryKey() -> String {
        return "id"
    }

    convenience public init(id: String, lessonId: String) {
        self.init()

        self.id = id
        self.lessonId = lessonId
    }
}
