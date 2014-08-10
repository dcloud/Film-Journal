//
//  Film.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

class Country: RLMObject {
    dynamic var name = ""
}

class Language: RLMObject {
    dynamic var name = ""
}

class Film: RLMObject {
    dynamic var title = ""
    dynamic var summary = ""
    dynamic var fullDescription = ""

    dynamic var country = RLMArray(objectClassName: Country.className())
    dynamic var language = RLMArray(objectClassName: Language.className())

    dynamic var runtime: NSInteger = 0
//    dynamic var alternateTitles: [String] = [""]

    dynamic var director: Person = Person()
    dynamic var actors = RLMArray(objectClassName: Person.className())

}
