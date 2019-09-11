//
//  AddMemoViewController.swift
//  NewScenary
//
//  Created by Takumi Kimura on 2018/03/21.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

import UIKit
import NCMB
import SVProgressHUD

class AddMemoViewController: UIViewController {

@IBOutlet var captionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        captionTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        let object = NCMBObject(className: "Caption")
        object?.setObject(captionTextView.text, forKey: "caption")
        object?.saveInBackground({ (error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "Error")
            } else {
               //アラート・・・だけどこれを毎回描くのはめんどうくさいからライブラリをつくろう。
                let alertController = UIAlertController(title: "保存完了", message: "メモの保存が完了しました。メモ一蘭に戻ります。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                }
                
        })
        
        
    }
    


}
