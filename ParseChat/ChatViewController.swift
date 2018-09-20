//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Pat Khai on 9/18/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var chatTable: UITableView!
    
    @IBOutlet weak var messageField: UITextField!
    var window = UIWindow()
    var messages: [PFObject] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTable.dataSource = self
        chatTable.delegate = self
        chatTable.rowHeight =  100
//        chatTable.estimatedRowHeight = 100
        queryMessage()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true )
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTable.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        let chat_message = message["text"] as! String
        cell.chatMessage.text = chat_message
        
        if let user = message["user"] as? PFUser {
            // User found! update username label with username
            cell.chatID.text = user.username
        } else {
            // No user found, set default username
            cell.chatID.text = "🤖"
        }
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            } else if let error = error {
                self.alertControl()
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
    }
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                self.alertControl2()
                print(error.localizedDescription)
            } else {
                let user = PFUser.current() ?? nil
                print("Successful logout")
                print(user as Any)
                
                self.performSegue(withIdentifier: "logout", sender: nil)
            }
            
        })
    }
    
    func alertControl2 () {
        let alertController = UIAlertController(title: "Network Error while logging out", message: "Try again" , preferredStyle: .alert)
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action) in
        
        //        }
        //        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    
    
    func alertControl () {
        let alertController = UIAlertController(title: "Problem saving message", message: "Try again" , preferredStyle: .alert)
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action) in
        
        //        }
        //        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    func queryMessage(){
    
        // construct query
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
    
                for message in posts{
                    print(message["text"])
                }
    
                self.messages = posts
                self.chatTable.reloadData()
    
            } else {
                print(error!.localizedDescription)
            }
        }
    
    }
    
    
    @objc func onTimer(){
        queryMessage()
        
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
