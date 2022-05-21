//
//  TweetViewController.swift
//  RealmSampleProject
//
//  Created by 中嶋裕也 on 2022/05/22.
//

import Foundation
import UIKit
import RealmSwift

class TweetViewController: UIViewController {
    
    @IBOutlet var imageButton: UIButton!
    @IBOutlet var tweetTextFeild: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // Viewの初期設定を行うメソッド
    func setUpViews() {
        
        imageButton.backgroundColor = .white
        imageButton.layer.cornerRadius = 8
        imageButton.layer.shadowColor = UIColor.black.cgColor
        imageButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        imageButton.layer.shadowOpacity = 0.5
        imageButton.layer.shadowRadius = 4.0
        imageButton.imageView?.contentMode = .scaleAspectFill
    }
    
    // キャンセルボタンを押したときのアクション
    @IBAction func didTapCancelButton() {
        self.dismiss(animated: true)
    }
    
    // ツイートボタンを押したときのアクション
    @IBAction func didTapTweetButton() {
        guard let _ = tweetTextFeild.text else { return }
        
        saveTweet()
        self.dismiss(animated: true)
    }
    
    // ツイートを保存するメソッド
    func saveTweet() {
        guard let tweetText = tweetTextFeild.text else { return }

        let tweet = Tweet()
        tweet.tweetText = tweetText
        
        // 画像がボタンにセットされてたら画像も保存
        if let tweetImage = imageButton.backgroundImage(for: .normal){
            let imageURLStr = saveImage(image: tweetImage)
            tweet.imageFileName = imageURLStr
        }
        
        try! realm.write({
            realm.add(tweet)
        })
    }
    
    // 画像を保存するメソッド
    func saveImage(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }
        
        do {
            let fileName = UUID().uuidString + ".jpeg"
            let imageURL = getImageURL(fileName: fileName)
            try imageData.write(to: imageURL)
            return fileName
        } catch {
            print("Failed to save the image:", error)
            return nil
        }
    }
    
    // URLを取得するメソッド
    func getImageURL(fileName: String) -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(fileName)
    }
    
    // 画像選択ボタンを押したときのアクション
    @IBAction func didTapImageButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
}


extension TweetViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // ライブラリから戻ってきた時に呼ばれるデリゲートメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return picker.dismiss(animated: true) }
        imageButton.setBackgroundImage(pickedImage, for: .normal)
        picker.dismiss(animated: true)
    }
}
