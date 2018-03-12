//
//  ApiHandler.swift
//  ca-movie-search
//
//  Created by Carlos Arenas on 3/10/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MovieData: Codable {
    let title: String
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}

extension MovieData {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        self.init(title:title)
    }
}

final class ApiHandler {

    func performSearch(for term: String, completion: @escaping (MovieData?) -> Void) {
        print(">>>>>> HERE")
        
        let parameters: Parameters = ["query": term, "format": "json", "page": 1, "api_key": "ab7af61e73ec7d42ab86366c0e1374e9"]
        
        Alamofire.request("http://api.themoviedb.org/3/search/movie", method: .get, parameters:parameters).responseJSON { response in
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("Success")
                default:
                    print("Error with response status: \(status)")
                }
            }
            
            //to get JSON return value
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                print(JSON)
            }
        }
    }
}
