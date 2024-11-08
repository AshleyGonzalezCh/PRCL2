//
//  Chapter.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

struct Capitulo: Codable{
    // Decodable: Permite convertir informacion json a un modelo de swift
    // Encodable: Permite convertir un modelo de siwft a JSON
    // Codable: Ambas al mismo tiempo
    var id: Int
    var title: String
    var number: Int
    var summary: String
    var words: Int
    var content: String
    var url: String
}
