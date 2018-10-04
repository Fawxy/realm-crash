//
//  TrackLessonViewController.swift
//  Instructor
//
//  Created by Steve Smith on 12/02/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import UIKit
import RealmSwift

let TrackLessonViewControllerIdentifier = "TrackLessonViewController"

class TrackLessonViewController: UIViewController {

    var lessonReportId: String!
    fileprivate var lessonReportItem: LessonReportItem!


    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        lessonReportItem = realm.object(ofType: LessonReportItem.self, forPrimaryKey: lessonReportId)

        let trackingCategory = LessonTrackingCategory.allValues[0]
        let trackingCategoryProgressItem = lessonReportItem.trackingCategoryProgress.filter("categoryName == '\(trackingCategory.apiName)'").first!
    }
}
