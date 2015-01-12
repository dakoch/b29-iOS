//
//  UserViewController.swift
//  TweeterClone
//
//  Created by Gru on 01/11/15.
//  Copyright (c) 2015 GruTech. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource {

//    var networkController : NetworkController
//    var userId  : String!
    var tweets : [Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("USER_CELL", forIndexPath: indexPath) as TweetCell
        let tweet = self.tweets![indexPath.row]

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
