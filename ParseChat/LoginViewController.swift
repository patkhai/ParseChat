//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Pat Khai on 9/17/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var passWord: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let newUser = PFUser()
            newUser.username = userName.text
            newUser.password = passWord.text
        
        // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                self.alertControl()
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                
                self.performSegue(withIdentifier: "login", sender: nil)
                // manually segue to logged in view
            }
        }    }
    
    
    @IBAction func login(_ sender: UIButton) {
        let username = userName.text ?? ""
        let password = passWord.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                self.alertControl2()
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                
                self.performSegue(withIdentifier: "login", sender: nil)
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    
    
    func alertControl () {
        let alertController = UIAlertController(title: "Username already existed", message: "Try a new one" , preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action) in
        
//        }
//        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    
    func alertControl2 () {
        let alertController = UIAlertController(title: "Invalid username/password", message: "Try again" , preferredStyle: .alert)
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action) in
        
        //        }
        //        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
