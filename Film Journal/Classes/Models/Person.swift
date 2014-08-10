//
//  Person.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Person: RLMObject {
    dynamic let firstName: String
    dynamic let lastName: String

    init(firstName: String, lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
        super.init()
    }

    func fullName () -> String {
        return firstName + " " + lastName
    }
}
