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
            // Notificamos a la UI cuando cambian los resultados
            self.updateUI?()
        }
    }
    
    // Closure para notificar cambios a la UI
    var updateUI: (() -> Void)?
    
    // Realiza la búsqueda usando el endpoint de `/search`
    func searchWorks(query: String, completion: @escaping (Result<[Work], Error>) -> Void) {
        NetworkService.shared.searchWorks(query: query) { [weak self] works in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let works = works {
                    self.searchResults = works
                    print(works)
                    completion(.success(works)) // Pasamos los resultados al closure
                } else {
                    print("Error: No se encontraron resultados.")
                    completion(.failure(NetworkError.noData))
                }
            }
        }
    }
    
    func clearResults() {
        searchResults = [] // Vacia los resultados actuales
    }

}

// Error personalizado para la red
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

// DeviantsNLiars
//Emeline_Sparkz
