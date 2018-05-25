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
    
    let apiUrl = "http://api.themoviedb.org"
    let apiEndPoint = "/3/search/movie"
    let api_key = "ab7af61e73ec7d42ab86366c0e1374e9"

    func performSearch(for term: String, page: Int, completion: @escaping (JSON?, Error?) -> ()) {
        
        let parameters: Parameters = ["query": term, "page": page, "api_key": self.api_key]
        print(parameters)
        let url = self.apiUrl + self.apiEndPoint
        
        Alamofire.request(url, method: .get, parameters:parameters).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let jsonResponse = JSON(rawValue: value)
                completion(jsonResponse, nil)
                
            case .failure(let error):
                completion(nil, error)
                return
            }
        }
    }
}
