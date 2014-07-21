//
//  Film.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Film: RLMObject {
    let title: String
    var summary: String?
    var fullDescription: String?

    var country: [String]?
    var language: [String]?

    var runtime: Int?
    var alternateTitles: [String]?

    var director: Person?
    var actors = RLMArray(objectClassName: Person.className())

    init(title: String) {
        self.title = title
        super.init()
    }
}
