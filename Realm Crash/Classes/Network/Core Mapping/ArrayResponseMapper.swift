//
//  ArrayResponseMapper.swift
//  Instructor
//
//  Created by Chris Byatt on 18/09/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import Foundation

protocol ArrayResponseMapperProtocol {
    associatedtype Item
    static func process(_ obj: AnyObject?) throws -> [Item]
}

class ArrayResponseMapper<A: ParsedItem> {

    static func process(_ obj: AnyObject?, mapper: ((AnyObject) throws -> A?)) throws -> [A] {
        guard let json = obj as? [[String: AnyObject]] else { throw ResponseMapperError.invalid }

        var items = [A]()
        for jsonNode in json {
            if let item = try mapper(jsonNode as AnyObject) {
                items.append(item)
            }
        }
        return items
    }
}
