//
//  TweetCell.swift
//  TweeterClone
//
//  Created by Gru/dakoch on 01/05/15.
//  Copyright (c) 2015 GruTech. All rights reserved.
//
//
// W1.D1.03[x] In addition to the text property, add a property to hold the username
//             of the person who tweeted the tweet

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetUserId: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetImage: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
    
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}