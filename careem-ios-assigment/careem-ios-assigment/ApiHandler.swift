//
//  ApiHandler.swift
//  careem-ios-assigment
//
//  Created by Carlos Arenas on 3/10/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation

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
        
    }
}
