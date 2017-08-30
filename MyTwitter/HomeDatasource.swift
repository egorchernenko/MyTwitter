//
//  HomeDatasource.swift
//  MyTwitter
//
//  Created by Egor on 28.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON
class HomeDatasource: Datasource, JSONDecodable {
    
    let users: [User]
    
    required init(json: JSON) throws {
        //print("Now ready to parse json: \n", json)
        
        var users = [User]()
        
        let arr = json["users"].array
        for userJson in arr!{
            let name = userJson["name"].stringValue
            let username = userJson["username"].stringValue
            let bio = userJson["bio"].stringValue
            
            let user = User(name: name, username: username, bioText: bio, profileImage: UIImage())
            
            users.append(user)
        }
        self.users = users
    }
    let tweets: [Tweet] = {
        let elonUser = User(name: "Elon Musk ", username: "@elonmusk", bioText: "Pics of SpaceX spacesuit developed for NASA commercial crew program coming out next week. Undergoing ocean landing mobility/safety tests.",profileImage: #imageLiteral(resourceName: "profile_image"))

        let tweet = Tweet(user: elonUser, message: "Welcome to nine step of my awesome app, relly you hope guye are you enjoy this stuff dddsdfsdfsdfsfsmsfjfksljfsjdkfsdklfkl;sdjdlksdjflkasdjfalsdjfasdlkfjsdklfjsdf;lkjaslajfalskjfadslfk;asjflkasdjflkasdjflaksfjasldkfjaslkfjasdlk;fjalaksjflkasfjeio;dklsfjasdokfl;sdjflkaqwoaksljdfmcao;skldfzc")
        let tweet2 = Tweet(user: elonUser, message: "Welcome to nine step of my awesome app, relly you hope guye are you enjoy this stuff")
        return [tweet,tweet2]
    }()
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self,TweetCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1{
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1{
            return tweets.count
        }
        return users.count
    }
}
