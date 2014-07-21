//
//  Entry.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

enum Reaction {
    case Undecided
    case Ambivalent
    case Like
    case Love
    case Disappointed
    case Dislike
    case Hate

    func simpleDescription() -> String {
        switch self {
        case .Undecided:
            return "Undecided"
        case .Ambivalent:
            return "Ambivalent"
        case .Like:
            return "Like"
        case .Love:
            return "Love"
        case .Disappointed:
            return "Disappointed"
        case .Dislike:
            return "Dislike"
        case .Hate:
            return "Hate"
        default:
            return "Unknown"
        }
    }
}

class Entry: RLMObject {
    var film:Film
    var thoughts: String?
    var date = NSDate()
    var reaction:Reaction = .Undecided

    init(film:Film) {
        self.film = film
        super.init()
    }
}
