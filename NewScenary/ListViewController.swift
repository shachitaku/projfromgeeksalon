//
//  ListViewController.swift
//  NewScenary
//
//  Created by Takumi Kimura on 2018/03/21.
//  Copyright © 2018年 com.takumi0kimura. All rights reserved.
//

import UIKit
import NCMB

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var captionArray = [NCMBObject]()
    
    @IBOutlet var captionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionTableView.dataSource = self
        captionTableView.delegate = self
        
        //メモ一覧の不要な線を消す。
        captionTableView.tableFooterView = UIView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return captionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = captionArray[indexPath.row].object(forKey: "caption") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        
        //greyを解除する
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面の取得(Detail)
        if segue.identifier == "toDetail" {
            let detailViewController = segue.destination as! DetailViewController
            
            let selectedIndex = captionTableView.indexPathForSelectedRow!
            
            detailViewController.selectedCaption = captionArray[selectedIndex.row]
        }
        
    }
    

}
