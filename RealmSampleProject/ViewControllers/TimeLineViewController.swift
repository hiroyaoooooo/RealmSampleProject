//
//  TimeLineViewController.swift
//  RealmSampleProject
//
//  Created by 中嶋裕也 on 2022/05/21.
//

import UIKit
import RealmSwift

class TimeLineViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tweetButton: UIButton!
    
    let realm = try! Realm()
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        getTweetData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTweetData()
    }
    
    // Viewの初期設定を行うメソッド
    func setUpViews() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tweetButton.layer.cornerRadius = tweetButton.frame.width / 2
        tweetButton.layer.shadowColor = UIColor.black.cgColor
        tweetButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        tweetButton.layer.shadowOpacity = 0.5
        tweetButton.layer.shadowRadius = 4.0
    }
    
    // Realmからデータを取得してテーブルビューを再リロードするメソッド
    func getTweetData() {
        // TODO: ②保存済みのツイートを取得する
    }
    
    
}

extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource {
    
    // TableViewが何個のCellを表示するのか設定するデリゲートメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: ③Cellの個数を指定する
        return 10
    }
    
    // Cellの中身を設定するデリゲートメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
        guard let userImageView = cell.viewWithTag(1) as? UIImageView,
              let tweetLabel = cell.viewWithTag(3) as? UILabel,
              let tweetImageView = cell.viewWithTag(4) as? UIImageView else { return cell }
        // TODO: ④Cellの中身を指定する
        return cell
    }
    
    
//    // URLを取得するメソッド
//    func getImageURL(fileName: String) -> URL {
//        // TODO: ②-③ URLをゲットする②
//
//    }
    
    // Cellのサイズを設定するデリゲートメソッド
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: ②-④Cellの高さを指定する
        return 90
    }
    
}
