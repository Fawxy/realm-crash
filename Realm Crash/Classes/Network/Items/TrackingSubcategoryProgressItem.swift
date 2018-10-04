//
//  TrackingSubcategoryProgressItem.swift
//  Instructor
//
//  Created by Chris Byatt on 27/10/2017.
//  Copyright © 2017 Midrive. All rights reserved.
//

import Foundation
import RealmSwift

enum TrackingSubcategoryProgress: String {
    case started
    case prompted
    case independent
    case none
}

public class TrackingSubcategoryProgressItem: Object {
    @objc dynamic var subcategoryName: String!
    @objc dynamic var progress: String?

    public convenience init(subcategoryName: String, progress: String?) {
        self.init()

        self.subcategoryName = subcategoryName
        self.progress = progress
    }
}
