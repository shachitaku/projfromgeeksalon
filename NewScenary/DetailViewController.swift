//
//  DetailViewController.swift
//  NewScenary
//
//  Created by Takumi Kimura on 2018/03/21.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

import UIKit
import NCMB
import SVProgressHUD

class DetailViewController: UIViewController {
    
    var selectedCaption: NCMBObject!
    
    @IBOutlet var captionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionTextView.text = selectedCaption.object(forKey: "caption") as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func update () {
        // 自分用ノート。　.textがついてないと、変数を代入できない？型があってないものに代入してるっぽい。Threat signal SIGABRTが出る
        selectedCaption.setObject(captionTextView.text, forKey: "caption")
        selectedCaption.saveInBackground { (error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            } else {
                //成功して、前の画面に戻る
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func delete() {
        selectedCaption.deleteInBackground { (error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            } else {
                //削除成功して、前の画面に戻る
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
