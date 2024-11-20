//
//  WorkDetailViewModel.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import Foundation
 
class WorkDetailViewModel {
    var work: Work?
    var chapters: [Chapter] = []

    func loadChapters(completation: @escaping (Result<Void, Error>) -> Void) {
        if let workChapters = work?.chapters {
            chapters = workChapters
        }
        else{
            print("----aqui---")
            NetworkService.shared.fetchWorkDetails(workID: work!.id, completion: {
                [weak self] libro_des in
                DispatchQueue.main.async {
                    if let capitulos = libro_des {
                        self?.chapters = capitulos
                        
                        print(capitulos)
                        completation(.success(()))
                    }
                    else {
                        // completation(.failure("Algo paso wee... creeme"))
                    }
                    
                }
            })
        }
    }
}

