//
//  FilmsTableDataSource.swift
//  Film Journal
//
//  Created by Daniel Cloud on 8/10/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import UIKit
import Realm

class FilmsTableDataSource: NSObject, UITableViewDataSource {

    var array = RLMArray(objectClassName: Film.className())
    var notificationToken: RLMNotificationToken?

    override init() {
        // Set realm notification block
        super.init()
        notificationToken = RLMRealm.defaultRealm().addNotificationBlock { note, realm in
            self.reloadData()
        }

    }

    func reloadData() {
        array = Film.allObjects().arraySortedByProperty("title", ascending: true)
    }

    //MARK: - UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return Int(array.count)
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView!.dequeueReusableCellWithIdentifier("FilmCell", forIndexPath: indexPath) as UITableViewCell

        let object = array[UInt(indexPath!.row)] as Film

        cell.textLabel.text = object.title
            cell.detailTextLabel.text = object.director.fullName

        return cell
    }




}
