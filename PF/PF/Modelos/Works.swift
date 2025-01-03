//
//  WorksByAuthor.swift
//  PF
//
//  Created by alumno on 11/8/24.


import Foundation
struct Chapter: Codable {
    var id: Int?
    var title: String
    var number: Int
    var summary: String?
    var words: Int
    var url: String
    var content: String
}
 
struct Work: Codable {
    var id: Int
    var title: String
    //var author: String
    var username: String?
    var summary: String?
    var language: String
    var status: String
    var url: String
    var chapters: [Chapter]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case summary
        case language
        case status
        case url
        case chapters
        case username
    }
}

