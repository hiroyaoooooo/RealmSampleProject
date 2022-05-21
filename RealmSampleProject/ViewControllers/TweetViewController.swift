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
        // TODO: ①ツイートを保存する
    }
    
//    // 画像を保存しファイル名を返すメソッド
//    func saveImage(image: UIImage) -> String? {
//        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }
//        // TODO: ②-② 画像を保存する
//
//    }
//    
//    // URLを取得するメソッド
//    func getImageURL(fileName: String) -> URL {
//        // TODO: ②-① URLをゲットする
//    }
    
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
