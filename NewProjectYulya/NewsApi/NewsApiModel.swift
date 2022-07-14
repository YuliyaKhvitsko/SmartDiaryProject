//
//  NewsApiModel.swift
//  NewProjectYulya
//
//  Created by Yuliya Khvitsko on 11.07.22.


import Foundation
import ObjectMapper

class Content: Mappable {
    var content = [Article]()
    var status: String?
    var total: Int = 0
    

    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        status       <- map["status"]
        total        <- map["totalResults"]
        content      <- map["articles"]

    }
    
}

class Article: Mappable {
    var author: String?
    var title: String?
    var description: String?
    var content: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var source: Source?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        author       <- map["author"]
        title        <- map["title"]
        description  <- map["description"]
        content      <- map["content"]
        url          <- map["url"]
        urlToImage   <- map["urlToImage"]
        publishedAt  <- map["publishedAt"]
        source       <- map["source"]
        
    }
}

class Source: Mappable {
    var name: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map) {
        name      <- map["name"]
        
    }
}

extension Article {
    var ago: String? {
        let formatter = DateFormatter()
        guard let date = publishedAt else { return nil }

        formatter.locale = Locale(identifier: "en_US_POSIX") 
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dump(date)
        guard let test1 = formatter.date(from: date) else { return nil}

        formatter.dateFormat = "dd.MM.yy, hh:mm"
        formatter.locale = Locale(identifier: "ru_RU_POSIX")
        let test2 = formatter.string(from: test1)
        dump(test1)

  return test2
//return DateFormatter.localizedString(for: date, relativeTo: Data())
    }


    var titleDisplay: String {
        guard let title = title else { return "" }
        
        let components = title.components(separatedBy: " - ")
        guard let first = components.first else { return title }
        
        return first
    }
}

enum NewsCategory: String, CaseIterable {
    case general = "Общие"
    case business = "Бизнес"
    case entertainment = "Развлечения"
    case health = "Здоровье"
    case science = "Наука"
    case sports = "Спорт"
    case technology = "Технологии"

    
}
