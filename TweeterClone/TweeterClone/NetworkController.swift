//
//  NetworkController.swift
//  TweeterClone
//
//  Created by Gru on 01/10/15.
//  Copyright (c) 2015 GruTech. All rights reserved.
//

import Foundation
import Accounts
import Social

class NetworkController {

    var twitterAccount : ACAccount?
    var imageQueue = NSOperationQueue()

    init() {
        // Used to initially set values need when app starts up, or the class is
        // instantiated.
    }


    func fetchHomeTimeline( completionHandler : ([Tweet]?, String?) -> ()) {

        let accountStore = ACAccountStore()
        let accountType  = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)

        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted : Bool, error : NSError!) -> Void in
            if granted {

                let accounts = accountStore.accountsWithAccountType(accountType)
                if !accounts.isEmpty {

                    self.twitterAccount = accounts.first as? ACAccount
                    let requestURL      = NSURL( string: "https://api.twitter.com/1.1/statuses/home_timeline.json" )
                    let twitterRequest  = SLRequest( forServiceType: SLServiceTypeTwitter,
                                                      requestMethod: SLRequestMethod.GET,
                                                                URL: requestURL,
                                                         parameters: nil)

                        twitterRequest.account = self.twitterAccount
                        twitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in

                        switch response.statusCode {

                          case 200...299:
                               println( "statusCode[200...299]:  \(response.statusCode) Success message! " )

                               if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [AnyObject] {
                                    var tweets = [Tweet]()
                                    for object in jsonArray {
                                        if let jsonDictionary = object as? [String : AnyObject] {
                                            let tweet = Tweet(tweetInfo: jsonDictionary)
                                            tweets.append(tweet)
                                        }
                                    }
                                    println( "...\(tweets.count) " )

                                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                        completionHandler(tweets, nil)
                                    })
                               }
                            
                          case 300...599:
                               println( "statusCode[300...599]:  \(response.statusCode) Success message! " )
                               println("this is bad!")
                               completionHandler(nil, "this is bad!")

                           default:
                               println("default case fired")
                        }
                    }
                }
            }
            
        }
    }

    func downloadUserImageForTweet(tweet : Tweet, completionHandler : (image : UIImage) -> (Void)) {

        self.imageQueue.addOperationWithBlock { () -> Void in
            let url           = NSURL(string: tweet.imageURL)
            let imageData     = NSData(contentsOfURL: url!)
            let image         = UIImage(data: imageData!)
            tweet.image       = image
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completionHandler(image: image!)
            })
        }

    }

    func fetchImageForTweet(tweet : Tweet, completionHandler: (UIImage?) -> ()) {
        //image download
        if let imageURL = NSURL(string: tweet.imageURL) {
            //self.imageQueue.maxConcurrentOperationCount = 1
            self.imageQueue.addOperationWithBlock({ () -> Void in

                if let imageData = NSData(contentsOfURL: imageURL) {
                    tweet.image = UIImage(data: imageData)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completionHandler(tweet.image)
                    })

                    //return tweet.image!
                    //        cell.tweetImageView.image = tweet.image
                }
                
            })
        }
    }
    
// ==============================================================================
    /* Network controller does not inherit from ViewController, so there is no
       'viewDidLoad()' or 'didRecieveMemoryWarning()' to override.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } */
    
}
