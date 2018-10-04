//
//  TrackingSubcategoryItem.swift
//  Instructor
//
//  Created by Chris Byatt on 16/10/2017.
//  Copyright © 2017 Midrive. All rights reserved.
//

import Foundation
import RealmSwift

public class TrackingSubcategoryItem: Object, ParsedItem {
    @objc dynamic var categoryName: String!

    let subcategoryTitles = List<String>()

    public convenience init(categoryName: String, subcategoryTitles: [String]) {
        self.init()

        self.categoryName = categoryName
        subcategoryTitles.forEach { title in
            self.subcategoryTitles.append(title)
        }
    }
}
