//
//  FilmEditViewController.swift
//  Film Journal
//
//  Created by Daniel Cloud on 8/12/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import UIKit
import Realm

class FilmEditViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var saveButton: UIButton?
    @IBOutlet var filmTitle: UITextField?
    @IBOutlet var filmSummary: UITextView?
    @IBOutlet var filmRuntime: UITextField?

    var film: Film = Film()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("viewDidLoad: Film is \(self.film.title)")

        self.filmTitle?.text = self.film.title
        self.filmSummary?.text = self.film.summary
        self.filmRuntime?.text = "\(self.film.runtime)"
    }

    @IBAction func saveButtonTapped(AnyObject) {
        self.saveButton?.enabled = false;

        if let filmTitle = self.filmTitle?.text! {
            film.title = filmTitle

            println(filmTitle)

            if let filmSummary = self.filmSummary?.text {
                film.summary = filmSummary
            }
            if let runtime = self.filmRuntime?.text.toInt() {
                film.runtime = runtime
            }


//            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//            dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let realm = RLMRealm.defaultRealm()

            let idPredicate = NSPredicate(format: "uuid = %@", film.uuid)
            let existingInstances: RLMArray = Film.objectsWithPredicate(idPredicate)

            realm.beginWriteTransaction()
            if existingInstances.count > 0 {
                realm.deleteObjects(existingInstances)
            }
            realm.addObject(film)
            realm.commitWriteTransaction()

            dispatch_async(dispatch_get_main_queue()) {
                println(realm.path)
            }
//            }

        } else {
            println("Error")
        }

        self.saveButton?.enabled = true;
    }

    // MARK: - UITextViewDelegate

//    did
}
