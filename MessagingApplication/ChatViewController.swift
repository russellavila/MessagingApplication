//
//  ChatViewController.swift
//  MessagingApplication
//
//  Created by Consultant on 5/26/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var mainTextLabel: UILabel!
    
    private let database = Database.database().reference()
    private var previousMsg : [String] = []
    var login = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.addTarget(self, action: #selector(self.Auth), for: .touchUpInside)
        var x = 0
        
        FirebaseAuth.Auth.auth().signInAnonymously { (user, error) in
               if let error = error {
                 print("Sign in failed:", error.localizedDescription)

               } else {
                   print ("Signed in with uid:")
               }
            }

        database.observe(.value, with: { snapshot in
            //print(snapshot)

            if (x == 0) {
                for child in snapshot.children {
                    var dict = ""
                    let c = child as? DataSnapshot
                    dict = c?.key ?? ""
                    var otherdict = c?.childSnapshot(forPath: "text").value as? String
                    self.previousMsg.append(dict)
                    self.mainTextLabel.text?.append("\n\n" + dict + "\n")
                    self.mainTextLabel.text?.append(otherdict ?? "")
                    
                    //for other type of (key:value) in our database
                    otherdict = c?.value as? String
                    self.mainTextLabel.text?.append(otherdict ?? "")
                    
                }
                x += 1
            }
            
            if(x == 1){
                //print (self.previousMsg)
                
                for child in snapshot.children {
                    var dict = ""
                    let c = child as? DataSnapshot
                    dict = c?.key ?? ""
                    
                    if !(self.previousMsg.contains(dict)){
                        var otherdict = c?.childSnapshot(forPath: "text").value as? String
                        self.previousMsg.append(dict)
                        self.mainTextLabel.text?.append("\n\n" + dict + "\n")
                        self.mainTextLabel.text?.append(otherdict ?? "")
                        
                        //for other type of (key:value) in our database
                        otherdict = c?.value as? String
                        self.mainTextLabel.text?.append(otherdict ?? "")
                    }
                }
            }
        })

    }
    
    @IBAction func Auth(_ sender: Any) {
        //database.child("Russell_\(Date())").setValue("HelllOOOOooOOOOOOoo")
        //database.child("Russell_\(Date())").setValue(inputTextField.text)
        database.child(login + " \(Date())").setValue(inputTextField.text)
    }
}
