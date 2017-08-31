//
//  Tweet.swift
//  MyTwitter
//
//  Created by Egor on 30.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

struct Tweet: JSONDecodable {
    let user: User
    let message: String
    
    init(json: JSON) {
        let userJson = json["user"]
        self.user = User(json: userJson)
        
        self.message = json["message"].stringValue
    }
}
