//
//  Festival.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Festival: RLMObject {
    let name: String
    let year: Int

    var startDate: NSDate?
    var endDate: NSDate?

    var films = RLMArray(objectClassName: Film.className())

    init(name: String, year: Int) {
        self.name = name
        self.year = year
        super.init()
    }
}
