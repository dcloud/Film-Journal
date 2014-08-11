//
//  FilmsTableViewController.swift
//  Film Journal
//
//  Created by Daniel Cloud on 8/10/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import UIKit

class FilmsTableViewController: UITableViewController {

    @IBOutlet var addButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = FilmsTableDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonTapped(AnyObject) {
        self.performSegueWithIdentifier("ShowFilmDetail", sender: self)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
