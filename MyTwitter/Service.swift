//
//  Service.swift
//  MyTwitter
//
//  Created by Egor on 30.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service{
    
    let tron = TRON(baseURL: "http://api.letsbuildthatapp.com")
    
    static let sharedInstance = Service()
    
    func fetchHomeFeed(completion: @escaping (HomeDatasource) -> ()){
        
        let request: APIRequest<HomeDatasource,JSONError> = tron.request("/twitter/home")
        
        request.perform(withSuccess: { (homeDatasource) in
            completion(homeDatasource)
        }) { (err) in
            print("Failed to fetch json....", err)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
            
        }
    }
}
