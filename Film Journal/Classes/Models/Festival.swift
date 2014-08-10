//
//  Festival.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Festival: RLMObject {
    dynamic let name: String
    dynamic let year: Int

    dynamic var startDate: NSDate?
    dynamic var endDate: NSDate?

    dynamic var films = RLMArray(objectClassName: Film.className())

    init(name: String, year: Int) {
        self.name = name
        self.year = year
        super.init()
    }
}
