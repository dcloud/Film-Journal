//
//  FilmsTableViewController.swift
//  Film Journal
//
//  Created by Daniel Cloud on 8/10/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import UIKit

class FilmsTableViewController: UITableViewController, UITableViewDelegate {

    @IBOutlet var addButton: UIBarButtonItem?

    var selectedFilm: Film?
    var filmsDataSrc: FilmsTableDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.filmsDataSrc = FilmsTableDataSource()
        self.tableView.dataSource = self.filmsDataSrc
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.filmsDataSrc?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonTapped(AnyObject) {
        self.performSegueWithIdentifier("ShowFilmDetail", sender: self)
    }

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.selectedFilm = self.filmsDataSrc?.array.objectAtIndex(UInt(indexPath.row)) as? Film
        self.performSegueWithIdentifier("ShowFilmDetail", sender: self)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if let filmEditVC = segue.destinationViewController as? FilmEditViewController {
            if let selectedFilm = self.selectedFilm {
                filmEditVC.film = selectedFilm
            }
        }
    }

}
