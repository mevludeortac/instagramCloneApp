//
//  FeedViewController.swift
//  instagramCloneApp
//
//  Created by MEWO on 21.10.2021.
//

import UIKit
import Firebase
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEMail.text = "dude@gmail.com"
        cell.userPostImageView.image = UIImage(named: "ben")
        cell.caption.text = "ay bennnn"
        cell.likeCount.text = "0"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
