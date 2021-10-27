//
//  ViewController.swift
//  instagramCloneApp
//
//  Created by MEWO on 19.10.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var eMailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    @IBAction func signInClicked(_ sender: Any) {
        if eMailTxt.text != "" && passwordTxt.text != ""
            {
            Auth.auth().signIn(withEmail: eMailTxt.text!, password: passwordTxt.text!) { (autdaha, error) in
                if error != nil{
                    self.makeAlert(titleInput: "error!", messageInput: error?.localizedDescription ?? "error!")
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else{
            makeAlert(titleInput: "error!", messageInput: "Username/Password!!")
        }
    }
    @IBAction func signUpClicked(_ sender: Any) {
        if eMailTxt.text != "" && passwordTxt.text != ""
        {
            Auth.auth().createUser(withEmail: eMailTxt.text!, password: passwordTxt.text!) { (authdata, error) in
                if error != nil
                {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else{
            makeAlert(titleInput: "Error!", messageInput: "Username/Password!!")
        }
    }
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

