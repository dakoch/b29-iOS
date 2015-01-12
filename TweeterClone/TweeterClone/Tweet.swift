//
//  Tweet.swift
//  TweeterClone
//
//  Created by Gru/dakoch on 01/05/15.
//  Copyright (c) 2015 GruTech. All rights reserved.
//
// --------------------------------------------------------------------------------------------------------
// Monday, 2015-Jan-05
// W1.D1.02[x] Create your Tweet class with an initializer that takes a Dictionary
//             in as a parameter/
// --------------------------------------------------------------------------------------------------------

import UIKit

class Tweet {

    var text : String               // Tweet message text
    var userName : String           // Tweet author
    var imageURL : String           // Tweet image location
    var image : UIImage?            // Tweet image

    // Now, let's extract imformation from the users twitter account
    init( tweetInfo : NSDictionary ) {
        self.text      = tweetInfo["text"] as String

        let  userInfo  = tweetInfo["user"] as NSDictionary
             self.imageURL  = userInfo["profile_image_url"] as String
             self.userName  = userInfo["name"] as String
    }

    class func parseJSONDataIntoTweets(rawJSONData : NSData ) -> [Tweet]? {
        var error : NSError?
        if let JSONArray = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSArray {

            var tweets = [Tweet]()

            for JSONDictionary in JSONArray {
                if let tweetDictionary = JSONDictionary as? NSDictionary {
                    var newTweet = Tweet( tweetInfo : tweetDictionary )
                    tweets.append(newTweet)
                }
            }
            return tweets
        }
        return nil
    }

/* =====
    // Open the local json file and extract the 'text' value.                   W1.D1.02
    init( _ jsonDictionary : [String : AnyObject] ) {
        self.text = jsonDictionary["text"] as String                            // Tweet: message

        let userDictionary = jsonDictionary["user"] as [String : AnyObject]     // Dictionary for JSON 'user'
        self.userName = userDictionary["name"] as String                        //                JSON 'user.name'
        self.imageURL = userDictionary["profile_image_url"] as String           //  URL for profile image URL

        println(userDictionary)

        if jsonDictionary["in_reply_to_user_id"] is NSNull {
            println("nsnull")
        }
    }
   ======= */
}
