//
//  Entry.swift
//  Film Journal
//
//  Created by Daniel Cloud on 7/20/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Realm

enum Reaction: Int {
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
    dynamic var film:Film
    dynamic var thoughts: String?
    dynamic var date = NSDate()
    var reaction:Reaction = .Undecided
    dynamic var reactionValue: NSNumber {
        get {
            return NSNumber(integer: reaction.toRaw())
        }
    }


    init(film:Film) {
        self.film = film
        super.init()
    }
}
