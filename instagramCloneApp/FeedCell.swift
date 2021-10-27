//
//  FeedCell.swift
//  instagramCloneApp
//
//  Created by MEWO on 28.10.2021.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell  {

    @IBOutlet weak var userEMail: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var userPostImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
    }
}
