//
//  ViewController.swift
//  MessagingApplication
//
//  Created by Redghy on 5/20/22.
//

import UIKit



class LoginViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButton.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
    }
    
    @objc
    func buttonPressed() {
        //let detailVC = ChatViewController()
        //self.navigationController?.pushViewController(detailVC, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatVC = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        
        if (userTextField.text != ""){
            chatVC?.login = userTextField.text ?? "Russell: "
            self.navigationController?.pushViewController(chatVC ?? ChatViewController(), animated: true)
        } else {
            errorMessage.textColor = UIColor.red
        }
    }
}

