//
//  RegisterTableViewController.swift
//  Foodie
//
//  Created by 许Bill on 15-4-29.
//  Copyright (c) 2015年 Fudan.SS. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {

    
    let segueName = "Successful Register Segue"
    var validInput = false
    var successfullyRegister = false
    
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBAction func pushBack(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    @IBAction func registerAction(sender: UIButton) {
        let alertView = UIAlertView(title: "输入有误", message: "请完整填完信息", delegate: self, cancelButtonTitle: "关闭")
        if checkValid() {
            let phoneNumber = phoneNumberTextField.text
            let password = passwordTextField.text
            let confirmPassword = confirmPasswordTextField.text
            let nickname = nicknameTextField.text
            let regex = "^[0-9]{11}"
            
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            let valid = predicate?.evaluateWithObject(phoneNumber)
            if valid == false {
                alertView.message = "请填写11位纯数字的手机号码"
                alertView.show()
                return
            }
            if (password as NSString).length<5{
                alertView.message = "密码不得低于5位"
                alertView.show()
                return
            }
            if password != confirmPassword{
                alertView.message = "两次密码输入不同"
                alertView.show()
                return
            }
            
            
            
            validInput = true
            
            //MARK: HTTP Request Goes here
            let urlRequest = UserManager.registerRequest(phoneNumber, pwd: password, nickname: nickname)
            NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue(),
                completionHandler: {[weak self] (response, data, error) -> Void in
                println()
                if error == nil {
                    
                    println(data)
                    let user = UserManager.getUserFromData(data)
                    let appDele = UIApplication.sharedApplication().delegate as AppDelegate
                    appDele.currentUser = user
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let alertView = UIAlertView(title: "注册成功,欢迎来到吃货天堂!", message: nil, delegate: nil, cancelButtonTitle: "体验一下")
                        alertView.show()
                        self!.successfullyRegister = true
                        self!.performSegueWithIdentifier(self!.segueName, sender: self)
                    })
                }
            })
            
        }
        else{
            alertView.show()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func checkValid()->Bool{
        let phoneNumber = phoneNumberTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        let nickname = nicknameTextField.text
        if phoneNumber == "" || password == "" || confirmPassword == "" || nickname == "" {
            return false
        }
        return true
    }
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == segueName {
            return validInput && successfullyRegister
        }
        else{
            return super.shouldPerformSegueWithIdentifier(identifier, sender: sender)
        }
    }
}
