/* --------------------------------------------------------------------------------------------------------
//  ViewController.swift
//  TweeterClone
//
//  Created by Gru/dakoch on 01/05/15.
//  Copyright (c) 2015 GruTech. All rights reserved.
//
//
//  https://github.com/XVimProject/XVim  location of the XCode/Vim plug-in.
// --------------------------------------------------------------------------------------------------------
// Monday, 2015-Jan-05
//
// W1.D1.01[x] Create your MVC groups - Create groups: ModelLayer, ViewLayer, ControllerLayer
// W1.D1.02[x] Create your Tweet class with an initializer that takes a Dictionary
//             in as a parameter                                                            - 'Tweet.swift'
// W1.D1.03[x] In addition to the text property, add a property to hold the username
//             of the person who tweeted the tweet
// W1.D1.04[x] Drag the tweet.json file into your Xcode project
// W1.D1.05[x] Parse the json file into tweet objects
// W1.D1.06[ ] In addition to text, pull out the username from the json for each
//             tweet and use that property you added to hold it
// W1.D1.07[x] Display those tweet objects in the table view
// W1.D1.08[ ] Create a custom table view cell class with your own custom label
//             and image view
// --------------------------------------------------------------------------------------------------------
*/

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tweetTableView: UITableView!

    var tweets      = [Tweet]()
    var tweetImages = [UIImage]()

    let networkController = NetworkController()

    let DAY1 = false

    var edith = UIImage( named: "edith03.jpeg")

    func saySomthing( message : String ) -> String {
        println( message )
        return message
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tweetImages.append( UIImage( named: "edith03.jpeg")!)
        tweetImages += [UIImage(named: "gru02.jpeg")!]
        tweetImages += [UIImage(named: "NinjaEdith.jpg")!]

        // Let's take a look at the 'tweet.json' file in the 'Supporting Files' group in our 'TweeterClone' project
        if DAY1 {
            saySomthing("Tring out 'DAY1' code.")
            readLocalJSONFile()

        } else {
            // Now let's use the user's Twitter account for messages.
            self.tweetTableView.dataSource = self
//          self.tweetTableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CELL")
            self.tweetTableView.delegate = self
            self.tweetTableView.estimatedRowHeight = 144
            self.tweetTableView.rowHeight = UITableViewAutomaticDimension

            let errorString = ""
            self.networkController.fetchHomeTimeline { (tweets, errorString) -> () in
                if errorString == nil {
                    self.tweets = tweets!
                    self.tweetTableView.reloadData()
                } else {
                    //show user alert view telling them it didnt work
                }
                
                
                // Do any additional setup after loading the view, typically from a nib.
                //    
                
                
            }

        }
    }

    func readLocalJSONFile() {

        if let jsonPath = NSBundle.mainBundle().pathForResource( "tweet", ofType: "json" ) {
        if let jsonData = NSData(contentsOfFile: jsonPath) {
            var error : NSError?
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error:&error) as? [AnyObject] {
                for object in jsonArray {
                    if let jsonDictionary = object as? [String : AnyObject] {
                        let tweet = Tweet(tweetInfo: jsonDictionary)
                        self.tweets.append(tweet)
                    }

                }
                //self.tweetTableView.reloadData()
                self.tweetTableView.dataSource = self
            }
        } else {
            println("getting data from path failed")
        }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    func tableView( tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return self.tweets.count
    }

    func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath ) -> UITableViewCell {

        // Let's get the tweets from the 'tweets' array

        let cell  = tableView.dequeueReusableCellWithIdentifier( "CELL", forIndexPath: indexPath ) as TweetCell
        let tweet = self.tweets[indexPath.row]

        cell.tweetUserId.text = tweet.userName
        cell.tweetText.text   = tweet.text
        if tweet.image == nil {
            self.networkController.fetchImageForTweet(tweet, completionHandler: { (image) -> () in
                cell.tweetImage.image = tweet.image
        })
        } else {
            cell.tweetImage.image = tweet.image
        }
/*
        let imageURL = tweet.imageURL as String
        cell.tweetImage = imageURL.lastPathComponent
        cell.tweetImage = tweet. //     tweet.imageURL

*/
        println( "ViewController::tableView() cellForRowAtIndexPath() " )
        println( "indexPath \(indexPath.row) text[\(tweet.text)]" )
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)

 //       let tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("TWEETVC") as TweetViewController
 //           tweetVC.networkController = self.networkController
 //           tweetVC.tweet = self.tweets[indexPath.row]
 //       self.navigationController?.pushViewController(tweetVC, animated: true)
        
    }
}