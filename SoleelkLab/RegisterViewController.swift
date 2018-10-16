//
//  RegisterViewController.swift
//  SoleelkLab
//
//  Created by Ramzy on 10/15/18.
//  Copyright © 2018 Ramzy. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerPressed(_ sender: UIButton) {
        if passwordTextField.text == confirmPasswordTextField.text {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil {
                    print (error!)
                    let alertController = UIAlertController(title: "Error", message:
                        "Invaild Email or Password", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default,handler: nil))
    
                    self.present(alertController, animated: true, completion: nil)
    
                } else {
                    print("Registration Successful!")
    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeViewController
                    self.present(HomeViewController,animated: true , completion: nil)
                }
            }
        }
        else {
            let alertController = UIAlertController(title: "Error", message:
                "Password and confirm password does not match", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        
    }
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
    }
    


    
}
