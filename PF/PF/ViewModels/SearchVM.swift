//
//  SearchVM.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import Foundation
 
class SearchViewModel {

    var searchResults: [Work] = []
 
    // Realiza la búsqueda solo por autor

    func searchWorks(author: String, completion: @escaping (Result<Void, Error>) -> Void) {

        guard let url = URL(string: "http://127.0.0.1:8000/search?author=\(author)") else {

            completion(.failure(NetworkError.invalidURL))

            return

        }

        // Llamada HTTP a la API del backend

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {

                completion(.failure(error))

                return

            }
 
            guard let data = data else {

                completion(.failure(NetworkError.noData))

                return

            }
 
            do {

                // Decodificar la respuesta JSON

                let decoder = JSONDecoder()

                let response = try decoder.decode(SearchResponse.self, from: data)

                self.searchResults = response.results

                completion(.success(()))

            } catch {

                completion(.failure(error))

            }

        }

        task.resume()

    }

}

 
