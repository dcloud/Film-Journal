//
//  Film.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Film: RLMObject {
    dynamic let title: String
    dynamic var summary: String?
    dynamic var fullDescription: String?

    dynamic var country: [String]?
    dynamic var language: [String]?

    dynamic var runtime: NSNumber?
    dynamic var alternateTitles: [String]?

    dynamic var director: Person?
    dynamic var actors = RLMArray(objectClassName: Person.className())

    init(title: String) {
        self.title = title
        super.init()
    }
}
