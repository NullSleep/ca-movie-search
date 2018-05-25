//
//  MovieSearchResults.swift
//  movie-search
//
//  Created by Carlos Arenas on 3/12/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieSearchResults {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    var results: [MovieStruct]?

    init(page: Int, total_results: Int, total_pages: Int, results: [MovieStruct]) {
        self.page = page
        self.total_results = total_results
        self.total_pages = total_pages
        self.results = results
    }

    // Parse the response from the API Call
    static func movieSearchResultsFromReponse(searchResults: JSON) -> MovieSearchResults? {
        
        var searchResult: MovieSearchResults?
        
        if let page = searchResults["page"].int,
            let total_results = searchResults["total_results"].int,
            let total_pages = searchResults["total_pages"].int,
            let results = searchResults["results"].array {
            
                var movies = [MovieStruct]()
            
                for movieObject in results {
                    
                    let movie = MovieStruct(moviePoster: movieObject["poster_path"].string,
                                            movieName: movieObject["original_title"].string,
                                            releaseDate: movieObject["release_date"].string,
                                            movieOverview: movieObject["overview"].string)
                    movies.append(movie)
                    
                }
            
                searchResult = MovieSearchResults(page: page, total_results: total_results, total_pages: total_pages, results: movies)
        }
        
        return searchResult
    }
}
