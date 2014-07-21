//
//  Screening.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Screening: RLMObject {
    var startTime: NSDate
    var endTime: NSDate?
    var film: Film
    var location: String?
    var have_ticket: Bool = false

    init(film:Film, startTime:NSDate) {
        self.film = film
        self.startTime = startTime
        super.init()
    }
}
