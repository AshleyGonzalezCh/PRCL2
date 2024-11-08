//
//  ResultViewModel.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import Foundation
 
class ResultsViewModel {
    var works: [Work] = []
    // Cargar los trabajos de la búsqueda
    func loadWorks() {
        self.works = SearchViewModel().searchResults
    }
}
