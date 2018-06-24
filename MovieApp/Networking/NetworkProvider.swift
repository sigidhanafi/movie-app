//
//  NetworkProvider.swift
//  MovieApp
//
//  Created by Sigit Hanafi on 24/06/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import Foundation
import Moya

var apiKey = "9d2a61648c32785276abeaee4471a2f9"

enum NetworkProvider {
    case popular
}

extension NetworkProvider: TargetType {
    var baseURL: URL {
        switch self {
        case .popular:
            return URL(string: "https://api.themoviedb.org/3/movie")!
        default:
            return URL(string: "https://api.themoviedb.org/3/movie")!
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/popular"
        default:
            return ""
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var method: Moya.Method {
        switch self {
        case .popular:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .popular:
            return .requestParameters(parameters: ["api_key": apiKey, "language": "en", "page": "1"], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
