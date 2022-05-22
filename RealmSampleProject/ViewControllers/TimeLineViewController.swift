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
        tweets = Array(realm.objects(Tweet.self)).reversed()  // Realm DBから保存されてるツイートを全取得
        tableView.reloadData() // テーブルビューをリロード
    }
    
    
}

extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource {
    
    // TableViewが何個のCellを表示するのか設定するデリゲートメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweets.count
    }
    
    // Cellの中身を設定するデリゲートメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
        guard let tweetLabel = cell.viewWithTag(3) as? UILabel,
              let tweetImageView = cell.viewWithTag(4) as? UIImageView else { return cell }
        
        let tweet = tweets[indexPath.row]
        tweetLabel.text = tweet.tweetText
        
        if let imageFileName = tweet.imageFileName {
            let path = getImageURL(fileName: imageFileName).path // 画像のパスを取得
            if FileManager.default.fileExists(atPath: path) { // pathにファイルが存在しているかチェック
                if let imageData = UIImage(contentsOfFile: path) { // pathに保存されている画像を取得
                    tweetImageView.image = imageData
                } else {
                    print("Failed to load the image. path = ", path)
                }
            } else {
                print("Image file not found. path = ", path)
            }
        }
        return cell
    }
    
    
    // URLを取得するメソッド
    func getImageURL(fileName: String) -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(fileName)
    }
    
    // Cellのサイズを設定するデリゲートメソッド
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        return tweet.imageFileName == nil ? 90 : 310
    }
    
}
