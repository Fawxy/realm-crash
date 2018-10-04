//
//  LessonReportResponseMapper.swift
//  Instructor
//
//  Created by Chris Byatt on 26/10/2017.
//Copyright © 2017 Midrive. All rights reserved.
//

import Foundation
import RealmSwift

final class LessonReportResponseMapper: ResponseMapper<LessonReportItem>, ResponseMapperProtocol {

    static func process(_ obj: AnyObject?) throws -> LessonReportItem {
        return try process(obj, parse: { json in
            guard let id = json["id"] as? String else {
                return nil
            }

            let lessonId = json["lesson_id"] as? String

            let outstandingDetails = json["outstanding_details"] as? [String: [String]]

            // Theese parsers create the objects that should go in the lists
            var outstandingTrackingSubcategories = [TrackingSubcategoryItem]()
            outstandingDetails?.forEach { (categoryName, subcategories) in
                let trackingSubcategory = TrackingSubcategoryItem(categoryName: categoryName, subcategoryTitles: subcategories)
                outstandingTrackingSubcategories.append(trackingSubcategory)
            }

            var progress = json["progress"] as? [String: AnyObject]
            progress?.removeValue(forKey: "overall")

            var trackingCategoryProgress = [TrackingCategoryProgressItem]()
            progress?.forEach { (categoryName, progressObject) in
                let overallProgress = progressObject["overall"] as! Int

                let trackingCategoryProgressItem = TrackingCategoryProgressItem(categoryName: categoryName, overallProgress: overallProgress)

                let subcategoryProgresses = progressObject["sub_categories"] as? [[String: Any]]

                subcategoryProgresses?.forEach { (subcategoryProgress) in
                    let name = subcategoryProgress["name"] as! String
                    let progress = subcategoryProgress["progress"] as? String
                    let trackingSubcategoryProgressItem = TrackingSubcategoryProgressItem(subcategoryName: name, progress: progress)
                    trackingCategoryProgressItem.subcategoryProgressItems.append(trackingSubcategoryProgressItem)
                }

                trackingCategoryProgress.append(trackingCategoryProgressItem)
            }

            // Create the lesson report if the json is valid
            var lessonReport: LessonReportItem?
            if let lessonId = lessonId {
                lessonReport = LessonReportItem(id: id, lessonId: lessonId)
            } else {
                return nil
            }

            // Append the items to the list
            lessonReport!.outstandingTrackingSubcategories.append(objectsIn: outstandingTrackingSubcategories)
            lessonReport!.trackingCategoryProgress.append(objectsIn: trackingCategoryProgress)

            return lessonReport!
        })
    }
}
