//
//  EditUserInfoViewController.swift
//  NewScenary
//
//  Created by Takumi Kimura on 2018/03/23.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

import UIKit
import NCMB

//カメラやPhotoLibraryを使うには追加プロトコルが必要（imagepicker&navicont)
class EditUserInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userIDTextField: UITextField!
    @IBOutlet var introductionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.delegate = self
        userIDTextField.delegate = self
        introductionTextView.delegate = self
        
        let userID = NCMBUser.current().userName
        userIDTextField.text = userID
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        //イメージを選べるようなコード
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImageView.image = selectedImage
        
        //閉じるコード
        picker.dismiss(animated: true, completion: nil)
        
        //Image View の設定をAspect FillにしたりClip to BoundsにしたりするとGood!
        
        //ここからアップロード編(ima koko !!!!)
    }
    
    @IBAction func selectImage() {
        //アクションシートを出す
        //AlertControllerとAlertAction二種類あるよ
        let actionController = UIAlertController(title: "画像の選択", message: "選択して下さい", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            //カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
            let picker = UIImagePickerController()
            //カメラから画像を引っ張ってくる
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではカメラが使用できません。")
            }
            
        }
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            //アルバム起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
            let picker = UIImagePickerController()
            //フォトライブラリから画像を引っ張ってくる
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではフォトライブラリが使用できません。")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            //キャンセル
            actionController.dismiss(animated: true, completion: nil)
        }
        
        actionController.addAction(cameraAction)
        actionController.addAction(albumAction)
        actionController.addAction(cancelAction)
        self.present(actionController, animated: true, completion: nil)
    }
    
    @IBAction func closeEditViewController () {
        self.dismiss(animated: true, completion: nil)
    }
    
}

