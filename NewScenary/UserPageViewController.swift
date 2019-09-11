//
//  UserPageViewController.swift
//  NewScenary
//
//  Created by Takumi Kimura on 2018/03/23.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

import UIKit
import NCMB

class UserPageViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenu() {
        let alertController = UIAlertController(title: "メニュー", message: "メニューを選択して下さい", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in
            NCMBUser.logOutInBackground({ (error) in
                if error != nil {
                    print("error")
                } else {
                    //SignUp、SignInからのコードをパクって編集する
                    //ログアウト成功。サインイン画面にもどる。
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    //画面が切り替え
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //trueだったのをfalseにして、保持をなくす。
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                    
                }
            })
            
        }
        
        let deleteAction = UIAlertAction(title: "退会", style: .default) { (action) in
            let user = NCMBUser.current()
            user?.deleteInBackground({ (error) in
                if error != nil {
                    print("error")
                } else {
                    //ログアウト成功。サインイン画面にもどる。
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    //画面が切り替え
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //trueだったのをfalseにして、保持をなくす。
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        
        
        alertController.addAction(signOutAction)
        //重要なアクションだから、１回確認を通したほうが良い。
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
   

}
