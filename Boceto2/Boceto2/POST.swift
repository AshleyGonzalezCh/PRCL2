//
//  POST.swift
//  Boceto2
//
//  Created by alumno on 10/9/24.
//

import Foundation

struct Post: Decodable{
    //Decodable: Permiete convertir información json a un modelo de swift
    //Encodable: Permite convertir un JSON a información más entendible
    //Codable
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
