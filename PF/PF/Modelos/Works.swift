//
//  WorksByAuthor.swift
//  PF
//
//  Created by alumno on 11/8/24.


import Foundation
struct Chapter: Codable 
{   var id: Int
    var title: String
    var number: Int
    var summary: String?
    var words: Int
    var url: String
}
 
struct Work: Codable{
    // Decodable: Permite convertir informacion json a un modelo de swift
    // Encodable: Permite convertir un modelo de siwft a JSON
    // Codable: Ambas al mismo tiempo
    var id: Int
    var title: String
    var summary: String?
    var language: String
    var status: String
    var word_count: String
    var url: String
    var chapters: [Chapter]?
    
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case summary
        case language
        case status
        case url
        case wordCount = "word_count"
        case chapters
    }
}
