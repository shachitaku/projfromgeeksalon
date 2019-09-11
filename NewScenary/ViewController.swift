//
//  ViewController.swift
//  NewScenary
//
//  Created by Takumi Kimura on 2018/02/23.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

/** Important notes　重要なノート
1. 次のコードは、既存の ViewController にシンプルな地図を追加する方法を示しています。新しいアプリを作成するには、まず上記のインストールの指示に従い、Single View Application を新規に作成します。このとき、[Use Storyboards] を無効に、[Use Automatic Reference Counting]（ARC）を有効にします。
 ↑まだやってないかも？？
2. API key: AIzaSyAnP_kL8M3xAkjHNU2vgmqsPsWi8Wv6NOw
3. CoreLocationはこのサイトから学習https://qiita.com/chino_tweet/items/db3a536234a43a3c31d9
4.
5. mbaas
 application key: 5ee89f24f08a874a069948e5ac5d508dbe7f8957a0bac52d6ccd459642bbcc82
 client key: 3305ac6caae748938138f7388ea28e2d81b7c0086c0c65c340dd99ea153a1ab8
 6. https://qiita.com/sutchan/items/0a78042261ca3f0a7d91
 build architecture云々のお話（こういうエラー→clang: error: linker command failed with exit code 1 (use -v to see invocation)）
 7.　出来ていない部分.
 ・キーボードが出てきた時、キーボードが消えない
 →Tap Gesture Recognizerを使う
 →キーボード自体の設定をかえる
 ・重要なもの（退会など）に確認ボタン（Emailアドレスを記入するなど）を作る。
 ・SignUpのときに同じEmailが使えないことを書いたりする。同じIDもダメ。日本語ダメ。

 */
 

import UIKit
import GoogleMaps
import CoreLocation
import NCMB

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var sampleTextField: UITextField!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
      super.viewDidLoad()
/*      setupLocationManager()
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
         
    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    mapView.isMyLocationEnabled = true
    view = mapView
    
    // Creates a marker in the center of the map.
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
    marker.title = "Sydney"
    marker.snippet = "Australia"
    marker.map = mapView
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        print("latitude: \(latitude!)\nlongitude: \(longitude!)")
    }
        
*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


 
    @IBAction func save() {
        let object = NCMBObject(className: "Caption")
        object?.setObject(sampleTextField.text, forKey: "caption")
        object?.saveInBackground({ (error) in
            if error != nil {
                //エラーが発生したら
                print("error")
            }else {
                //保存に成功した場合
                print("success")
            }
        })
}
    @IBAction func loadData() {
        let query = NCMBQuery(className: "Caption")
        //絞込み
        //query?.whereKey("caption", equalTo: "おはよう")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                //エラー
                print("error")
            }else{
                //上手くデータが取得できた場合
               // print(result)
                let captions = result as! [NCMBObject]
               // print(captions.first)
                let text = captions.last?.object(forKey: "caption") as! String
                print(text)
                self.sampleTextField.text = text
            }
        })
    }
    
    @IBAction func update() {
        let query = NCMBQuery(className: "Caption")
        query?.whereKey("caption", equalTo: "こんにちは")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print("error")
            } else {
                let captions = result as! [NCMBObject]
                let textObject = captions.first
                textObject?.setObject("こんばんは", forKey: "caption")
                textObject?.saveInBackground({ (error) in
                    if error != nil {
                        print("error")
                    }else {
                        print("Update succeed")
                    }
                })
            }
        })
    }
    
    @IBAction func delete() {
        let query = NCMBQuery(className: "caption")
        query?.whereKey("caption", equalTo: "テスト")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print("error")
            } else {
                let captions = result as! [NCMBObject]
                let textObject = captions.first
                textObject?.deleteInBackground({ (error) in
                    if error != nil{
                        print("error")
                    } else {
                        print("Delete Succeed")
                    }
                })
            }
        })
    }
 

}
