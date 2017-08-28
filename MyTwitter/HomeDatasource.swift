//
//  HomeDatasource.swift
//  MyTwitter
//
//  Created by Egor on 28.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import LBTAComponents

class HomeDatasource: Datasource {
    
    let users: [User] = {
        let elonUser = User(name: "Elon Musk ", username: "@elonmusk", bioText: "Pics of SpaceX spacesuit developed for NASA commercial crew program coming out next week. Undergoing ocean landing mobility/safety tests.",profileImage: #imageLiteral(resourceName: "profile_image"))
        let rayUser = User(name: "Ray Wenderlich", username: "@wenderlich", bioText: "welcome back to the swift tutorial text text text text text text text text text text welcome back to the swift tutorial text text text text text text text text text text welcome back to the swift tutorial text text text text text text tex",profileImage: #imageLiteral(resourceName: "ray_wenderlich"))
        let elonUser2 = User(name: "Elon Musk ", username: "@elonmusk", bioText: "Pics of SpaceX spacesuit developed for NASA commercial crew program coming out next week. Undergoing ocean landing mobility/safety tests.",profileImage: #imageLiteral(resourceName: "profile_image"))
        
        
        return [elonUser, rayUser,elonUser2]
    }()
    
    //let words = ["user1","user2","user3"]
    let tweets = ["tweet1", "tweet2"]
    
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
