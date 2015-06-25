//
//  LogonViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-5-24.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class LogonViewController: UIViewController {

    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    let segueName = "Successful Logon Segue"
    var validInput = false
    var successfullyLogon = false
    //MARK: Logon Action
    @IBAction func logonAction(sender: UIButton) {
        let phoneNumber = phoneNumberTextField.text
        let password = passwordTextField.text
        let alertView = UIAlertView(title: "输入有误", message: "手机号码未输入", delegate: self, cancelButtonTitle: "关闭")
        if phoneNumber == "" {
            alertView.show()
            return
        }
        if password == "" {
            alertView.message = "密码未输入"
            return
        }
        validInput = true
        passwordTextField.resignFirstResponder()
        //MARK: HTTP Request goes here
        indicator.startAnimating()
        let urlRequest = UserManager.loginRequest(phoneNumber, pwd: password)
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue(), completionHandler: {[weak self](response, data, error) -> Void in
            if error == nil {
                self!.indicator.stopAnimating()
                let logonUser = User.convertUser(SWXMLHash.parse(data))
                let appDele = UIApplication.sharedApplication().delegate as AppDelegate
                appDele.currentUser = logonUser
                self!.successfullyLogon = true
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self!.performSegueWithIdentifier(self!.segueName, sender: self!)
                    

                })
            }
            else{
                
            }
        })
        
        
    }
    @IBAction func resignKeyboardByTouchBackground(sender: UITapGestureRecognizer) {
        phoneNumberTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        println("Success:  \(successfullyLogon)")
        if identifier == segueName {
            if validInput && successfullyLogon {
                self.successfullyLogon = false
                validInput = false
                return true
            }
            return false
        }
        else{
            return super.shouldPerformSegueWithIdentifier(identifier, sender: sender)
        }
    }
}
