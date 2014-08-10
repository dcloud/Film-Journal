//
//  Festival.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Festival: RLMObject {
    dynamic var name: String = ""
    dynamic var year: Int = 2014

    dynamic var startDate: NSDate = NSDate()
    dynamic var endDate: NSDate = NSDate()

    dynamic var films = RLMArray(objectClassName: Film.className())

}
