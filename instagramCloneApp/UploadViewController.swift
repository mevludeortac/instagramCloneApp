//
//  UploadViewController.swift
//  instagramCloneApp
//
//  Created by MEWO on 21.10.2021.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIDocumentPickerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var caption: UITextField!
    //another upload actions
    @IBOutlet weak var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert(titleInput: String, messageInput: String)
    {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func uploadButtonClicked(_ sender: Any) {
        let storage  = Storage.storage()
        //bu referansı kullanarak hangi klasörle çalışacağımızı, nereye ne kaydedeceğimiz belirliyoruz
        let storageRefererence = storage.reference()
        //eğer "media" klasörünü elle oluşturmadıysak bu şekilde kendisi de oluşturacaktır.
        let mediaFolder = storageRefererence.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.2)
        {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil
                    {
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                    }
                else{
                    imageReference.downloadURL { (url, error) in
                        if error == nil
                        {
                            let imageUrl = url?.absoluteString
                            //database
                            let firestoreDatabase = Firestore.firestore()
                            //firestore database'ini yazmak, okumak ve değişiklikleri dinlemek için oluşturduğumuz obje
                            var firestoreReference : DocumentReference? = nil
                            let firestorePost = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.caption.text!, "date": FieldValue.serverTimestamp() , "likes" :0] as [String : Any]
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil{
                                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error" )
                                }
                                else{
                                    self.imageView.image = UIImage(named: "click.jpg")
                                    self.caption.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
   

}
