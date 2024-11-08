//
//  WorkDetailViewModel.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import Foundation
 
class WorkDetailViewModel {
    var work: Work?
    var chapters: [Chapter]? = []
    func loadChapters() {
        guard let work = work else { return }
        self.chapters = work.chapters
    }
}
