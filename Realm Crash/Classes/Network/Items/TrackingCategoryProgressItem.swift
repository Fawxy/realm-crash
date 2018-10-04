//
//  TrackingCategoryProgressItem.swift
//  Instructor
//
//  Created by Chris Byatt on 27/10/2017.
//  Copyright © 2017 Midrive. All rights reserved.
//

import Foundation
import RealmSwift

public class TrackingCategoryProgressItem: Object {
    @objc dynamic var categoryName: String!
    @objc dynamic var progress: Int = 0

    let subcategoryProgressItems = List<TrackingSubcategoryProgressItem>()

    public convenience init(categoryName: String, overallProgress: Int) {
        self.init()

        self.categoryName = categoryName
        self.progress = overallProgress
    }
}
