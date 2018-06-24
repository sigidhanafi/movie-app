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
    case upcoming
    case topRated
}

extension NetworkProvider: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/popular"
        case .upcoming:
            return "/upcoming"
        case .topRated:
            return "/top_rated"
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
        case .upcoming:
            return .get
        case .topRated:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .popular:
            return .requestParameters(parameters: ["api_key": apiKey, "language": "en", "page": "1"], encoding: URLEncoding.queryString)
        case .upcoming:
            return .requestParameters(parameters: ["api_key": apiKey, "language": "en"], encoding: URLEncoding.queryString)
        case .topRated:
            return .requestParameters(parameters: ["api_key": apiKey, "language": "en", "page": "1"], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
