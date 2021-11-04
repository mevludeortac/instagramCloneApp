//
//  FeedCell.swift
//  instagramCloneApp
//
//  Created by MEWO on 28.10.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
class FeedCell: UITableViewCell  {

    @IBOutlet weak var userEMail: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
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
        let fireStoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeCount.text!){
            let likeStore = ["likes" : likeCount + 1 ] as [String: Any]
            fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
        
    }
}
