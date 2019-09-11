//
//  SignInViewController.swift
//  NewScenary
//
//  Created by Takumi Kimura on 2018/03/23.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

import UIKit
import NCMB

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var userIDTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        userIDTextField.delegate = self
        passwordTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signIn() {
        
        if (userIDTextField.text?.count)! > 0 && (passwordTextField.text?.count)! > 0 {
        NCMBUser.logInWithUsername(inBackground: userIDTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("error")
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                //これから毎回ログインしなくていいように。ログイン状態の保持
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")
                ud.synchronize()
            }
            }
        
        }
        
    }
    
    @IBAction func forgetPassword() {
            
    }


}

