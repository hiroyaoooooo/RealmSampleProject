//
//  Tweet.swift
//  RealmSampleProject
//
//  Created by 中嶋裕也 on 2022/05/21.
//

import Foundation
import RealmSwift


class Tweet: Object {
    @objc dynamic var tweetText: String = ""
    @objc dynamic var imageFileName: String?
}
