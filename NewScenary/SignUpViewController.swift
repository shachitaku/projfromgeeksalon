//
//  SignUpViewController.swift
//  NewScenary
//
//  Created by Takumi Kimura on 2018/03/23.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userIDTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIDTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self

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
    
    @IBAction func signUp() {
        let user = NCMBUser()
        
        //userの文字数４文字以上か？？
        if (userIDTextField.text?.count)! < 4 {
            print("文字数が足りません")
            return
        }
        
        user.userName = userIDTextField.text!
        user.mailAddress = emailTextField.text!
        if passwordTextField.text == confirmTextField.text {
            user.password = passwordTextField.text!
        } else {
            //アラートココにつけよう！！ボタン押しても反応しない。
            print("パスワードの不一致")
        }
        
        user.signUpInBackground { (error) in
            if error != nil {
                //エラーが有った場合
                print("error")
            } else {
                //登録が成功した場合
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                //画面が切り替え
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                //これから毎回ログインしなくていいように。ログイン状態の保持
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")
                ud.synchronize()
            }
        }
        
    }

}
