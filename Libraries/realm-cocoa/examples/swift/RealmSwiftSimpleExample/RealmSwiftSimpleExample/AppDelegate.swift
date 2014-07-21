////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import UIKit
import Realm

class Dog: RLMObject {
    var name = ""
    var age = 0
}

class Person: RLMObject {
    var name = ""
    var dogs = RLMArray(objectClassName: Dog.className())
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        let rootVC = UIViewController()
        self.window!.rootViewController = rootVC
        
        deleteRealmFile()
        
        // Create a standalone object
        var mydog = Dog()
        
        // Set & read properties
        mydog.name = "Rex"
        mydog.age = 9
        println("Name of dog: \(mydog.name)")
        
        // Realms are used to group data together
        let realm = RLMRealm.defaultRealm() // Create realm pointing to default file
        
        // Save your object
        realm.beginWriteTransaction()
        realm.addObject(mydog)
        realm.commitWriteTransaction()
        
        // Query
        var results = Dog.objectsInRealm(realm, withPredicate: NSPredicate(format: "name contains 'x'"))

        // Queries are chainable!
        var results2 = results.objectsWithPredicate(NSPredicate(format: "age > 8"))
        println("Number of dogs: \(results.count)")
        
        // Link objects
        var person = Person()
        person.name = "Tim"
        person.dogs.addObject(mydog)
        
        realm.beginWriteTransaction()
        realm.addObject(person)
        realm.commitWriteTransaction()

        // Thread-safety
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let otherRealm = RLMRealm.defaultRealm()
            var otherResults = Dog.objectsInRealm(otherRealm, withPredicate: NSPredicate(format:"name contains 'Rex'"))
            println("Number of dogs \(otherResults.count)")
        })
        
        return true
    }
    
    func deleteRealmFile() {
        let documentsPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        var path = documentsPaths.stringByAppendingPathComponent("default.realm")
        NSFileManager.defaultManager().removeItemAtPath(path, error: nil)
    }
}
