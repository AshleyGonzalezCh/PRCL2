//
//  SearchVM.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import Foundation

class SearchViewModel {

    // Aquí almacenamos los resultados de la búsqueda
    var searchResults: [Work] = [] {
        didSet {
            // Actualizamos la UI cuando cambian los resultados
            self.updateUI?()
        }
    }
    
    // El closure que notificará cuando los resultados cambien
    var updateUI: (() -> Void)?
    
    // Realiza la búsqueda solo por autor
    func searchWorks(author: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        // Escapar el nombre del autor para la URL
        guard let escapedAuthor = author.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "http://161.97.164.147:8000/user/\(escapedAuthor)") else {
            print("URL inválida")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // Llamada HTTP a la API del backend
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            // Manejo de errores de red
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
 
            guard let data = data else {
                print("No se recibió data")
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                // Decodificar la respuesta JSON en un array de Work
                let decoder = JSONDecoder()
                let response = try decoder.decode(User.self, from: data)
                print(response)

                // Actualizamos los resultados con la respuesta decodificada
                self.searchResults = response.works
                completion(.success(()))

            } catch {
                print("Error al decodificar: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

// Error personalizado para la red
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
