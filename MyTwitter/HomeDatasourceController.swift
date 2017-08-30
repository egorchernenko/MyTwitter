//
//  HomeDatasourceController.swift
//  MyTwitter
//
//  Created by Egor on 28.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDatasourceController : DatasourceController{
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        
        setupNavigationBarItems()
        
//        let homeDatasource = HomeDatasource()
//        self.datasource = homeDatasource
        fetchHomeFeed()
    }
    
    let tron = TRON(baseURL: "http://api.letsbuildthatapp.com")
    
    class Home: JSONDecodable{
        
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
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")

        }
    }
    
    fileprivate func fetchHomeFeed(){
        //start json fetching with tron
        
        let request: APIRequest<HomeDatasource,JSONError> = tron.request("/twitter/home")
        
        request.perform(withSuccess: { (homeDatasource) in
            print("Successfullu fetched json objects")
            
            self.datasource = homeDatasource
            
            print(homeDatasource.users.count)
        }) { (err) in
            print("Failed to fetch json....", err)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let user = self.datasource?.item(indexPath) as? User{
            
            let approximateWidthOfTextView = view.frame.width - 12 - 50 - 12 - 2
            let size = CGSize(width: approximateWidthOfTextView, height: 1000)
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
            
            let estimatedFrame = NSString(string: user.bioText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 66)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if section == 1 {
            return .zero
        }
        
        return CGSize(width: view.frame.width, height: 64)
    }
}

