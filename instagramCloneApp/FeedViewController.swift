//
//  FeedViewController.swift
//  instagramCloneApp
//
//  Created by MEWO on 21.10.2021.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseFirestore
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    @IBOutlet weak var tableView: UITableView!
    
    var userEMailArray = [String]()
    var userCaptionarray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        getDataFromFirestore()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEMail.text = userEMailArray[indexPath.row]
        cell.userPostImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.caption.text = userCaptionarray[indexPath.row]
        cell.likeCount.text = String(likeArray[indexPath.row])
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEMailArray.count
    }
    
    func getDataFromFirestore(){
        let fireStoreDatabase = Firestore.firestore()
        //bu satır dökümanlarda derine inmek istedikçe uzar gider, şimdilik sadece post ile ilgileniyoruz-veri çektiğimiz kısım
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else{ //firestoredaki bütün dökümanlar tek tek bulunur ve bunları loopa alırız.
                if snapshot?.isEmpty != true && snapshot != nil{
                    //yeni veri yüklerken
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEMailArray.removeAll(keepingCapacity: false)
                    self.userCaptionarray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    //döküman dizisi verir
                    for document in snapshot!.documents {
                        let documentId = document.documentID
                        self.documentIdArray.append(documentId)
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEMailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String {
                            self.userCaptionarray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let userImage = document.get("imageUrl") as? String {
                            self.userImageArray.append(userImage)
                        }
                    }
                    self.tableView.reloadData()

                }
            }
    }
}
}
