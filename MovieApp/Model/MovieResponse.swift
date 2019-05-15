//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Sigit Hanafi on 13/05/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import Foundation

struct MovieResponse {
    public let page: Int
    public let totalResults: Int
    public let results: [MovieResult]
}

extension MovieResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults //= "total_results"
        case results //= "results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
        self.results = try container.decode([MovieResult].self, forKey: .results)
    }
}

struct MovieResult {
    public let id: Int
    public let title: String
    public let posterPath: String
}

extension MovieResult: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
    }
}

