//
//  Usuario.swift
//  Boceto2
//
//  Created by alumno on 10/21/24.
//

import Foundation
struct Usuario: Codable{
    //Decodable: Permiete convertir información json a un modelo de swift
    //Encodable: Permite convertir un JSON a información más entendible
    //Codable: Ambas al mismo tiempo
    var id: Int
    var name: String
    var username: String
    var email: String
}
