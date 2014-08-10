//
//  Person.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Person: RLMObject {
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""

    var fullName: String {
        get {
            return firstName + " " + lastName
        }
    }
}
