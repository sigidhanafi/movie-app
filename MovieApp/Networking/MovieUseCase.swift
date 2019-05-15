//
//  MovieUseCase.swift
//  MovieApp
//
//  Created by Sigit Hanafi on 13/05/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import Moya

protocol MovieUseCase {
    func loadPopular(page: String, completion: @escaping ((MovieResponse) -> Void)) -> Void
}

class DefaultMovieUseCase: MovieUseCase {
    private let provider = MoyaProvider<MovieTarget>()
    
    func loadPopular(page: String, completion: @escaping ((MovieResponse) -> Void)) {
        provider.request(MovieTarget.popular(page: page)) { (response) in
            guard let respo = response.value?.data else {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let movieResponse = try? decoder.decode(MovieResponse.self, from: respo) else {
                return
            }
            completion(movieResponse)
        }
    }
    
}
