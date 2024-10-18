//
//  provedor_publicaciones.swift
//  boceto_2_CellView
//
//  Created by Jadzia Gallegos on 09/10/24.
//

import Foundation
import UIKit

class ProveedorDePublicaciones{
    let url_de_publicaciones = "https://jsonplaceholder.typicode.com/"
    var  lista_de_publicaciones: [Post] = []
    
    /*
    static var autoreferencia: ProveedorDePublicaciones = {
        // Esta version es solo para añadir configuracion o cosas importatnes durante la inicializacion
        let instancia = ProveedorDePublicaciones()
        return instancia
    }()
     */
    static var autoreferencia = ProveedorDePublicaciones()
    
    private init() {}
    
    func obtener_publicaicones(que_hacer_al_recibir: @escaping ([Post]) -> Void) {
    // func obtener_publicaicones() async throws -> [Publicacion] {
        let ubicacion = URL(string: "\(url_de_publicaciones)posts")!
        URLSession.shared.dataTask(with: ubicacion) {
                (datos, respuesta, error) in do {
                    if let publicaciones_recibidas = datos{
                        let prueba_de_interpretacion_de_datos = try JSONDecoder().decode([Post].self, from: publicaciones_recibidas)
                        
                        self.lista_de_publicaciones = prueba_de_interpretacion_de_datos
                        que_hacer_al_recibir(prueba_de_interpretacion_de_datos ?? [])
                    }
                    else {
                        print(respuesta)
                    }
                } catch {
                    print("Error")
                }
        }.resume()
    }
    
    func obtener_publicaicon(id: Int, que_hacer_al_recibir: @escaping (Post) -> Void) {
        let ubicacion = URL(string: "\(url_de_publicaciones)posts/\(id)")!
        URLSession.shared.dataTask(with: ubicacion) {
                (datos, respuesta, error) in do {
                    if let publicaciones_recibidas = datos{
                        let prueba_de_interpretacion_de_datos = try JSONDecoder().decode(Post.self, from: publicaciones_recibidas)
                        que_hacer_al_recibir(prueba_de_interpretacion_de_datos)
                    }
                    else {
                        print(respuesta)
                    }
                } catch {
                    print("Error")
                }
        }.resume()
    }
    
    
    
    func realizar_subida_de_publicacion(publicaicon_nueva: Post) {
        // func obtener_publicaicones() async throws -> [Publicacion] {
            let ubicacion = URL(string: url_de_publicaciones)!
            URLSession.shared.dataTask(with: ubicacion) {
                (datos, respuesta, error) in do {}
            }.resume()
        }
}
