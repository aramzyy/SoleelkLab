//
//  ViewController.swift
//  SoleelkLab
//
//  Created by Ramzy on 10/15/18.
//  Copyright © 2018 Ramzy. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

 
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print (error!)
                let alertController = UIAlertController(title: "Error", message:
                    "Wrong Email or Password", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                print("Log In Successful !")
                 let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeViewController
                self.present(HomeViewController,animated: true , completion: nil)
               
            }
        }
        
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let RegisterViewController = storyBoard.instantiateViewController(withIdentifier: "register") as! RegisterViewController
            self.present(RegisterViewController,animated: true , completion: nil)
    }
    

}

