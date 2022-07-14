//
//  NetworkManager.swift
//  NewProjectYulya
//
//  Created by Yuliya Khvitsko on 11.07.22.
//

import Foundation

import UIKit
import Moya
import Moya_ObjectMapper

class NetworkManager {
   static private let provaider = MoyaProvider<NA>(plugins: [NetworkLoggerPlugin()]) 
    
    class func getNews(type: NewsCategory? = nil, success: ((Content) -> ())?, failure: (() -> ())?) {
       provaider.request(.getNews(type: type)) { result in
            switch result {
            case .success(let response):
                guard let articles = try? response.mapObject(Content.self) else {
                    print("Не удалось распарсить ответ для сервера.")
                    failure?()
                    return
                }
                print("Удалось получить ответ от сервера.\nКоличество отделений: \(articles.content.count)")
                success?(articles)
            case .failure(let error):
                print(error.localizedDescription)
                failure?()
            }
        }
    }
}


