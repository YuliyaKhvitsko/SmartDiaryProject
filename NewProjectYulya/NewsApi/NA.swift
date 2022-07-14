//
//  NA.swift
//  NewProjectYulya
//
//  Created by Yuliya Khvitsko on 11.07.22.
//

import Foundation
import Moya

enum NA {
    case getNews(type: NewsCategory?)

}

extension NA: TargetType {
    var baseURL: URL {
        return URL(string: "https://newsapi.org/")!
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/v2/top-headlines"
    
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        guard let params = parameters else { return .requestPlain }
        return .requestParameters(parameters: params, encoding: encoding)
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getNews:
            return URLEncoding.queryString
    
        }
    }
    
    var parameters: [String : Any]? {
        var params = [String : Any]()
        
        switch self {
        case .getNews(let category):
            params["country"] = "ru"
            params["apiKey"] = "db466569ab354d3288e8c12242559890"
            params["category"] = category

        }
        
        return params
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
