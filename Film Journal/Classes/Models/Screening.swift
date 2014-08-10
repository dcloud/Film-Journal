//
//  Screening.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Screening: RLMObject {
    dynamic var startTime: NSDate = NSDate()
    dynamic var endTime: NSDate = NSDate()
    dynamic var film: Film = Film()
    dynamic var location: String = ""
    dynamic var have_ticket: Bool = false

}
