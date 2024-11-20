//
//  WorkDetailViewController.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import UIKit

class WorkDetailViewController: UIViewController {

    @IBOutlet weak var ResumenObra: UILabel!
    @IBOutlet weak var LenguajeObra: UILabel!
    @IBOutlet weak var TituloObra: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var work: Work?
    var viewModel: WorkDetailViewModel!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            viewModel = WorkDetailViewModel()
            viewModel.work = work
            viewModel.loadChapters(){
                [weak self] resultado in
                switch(resultado){
                case .success(_):
                    DispatchQueue.main.async {
                        self?.work?.chapters = self?.viewModel.chapters
                        self?.collectionView.reloadData()
                    }
                case .failure(_):
                    print("Error")
                }
            }
            

            // Configurar collectionView
            collectionView.delegate = self
            collectionView.dataSource = self
            
            TituloObra.text = self.work?.title
            LenguajeObra.text = self.work?.language
            ResumenObra.text = self.work?.summary
        }
    }

    extension WorkDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return work?.chapters?.count ?? 0
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let chapter = work?.chapters?[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cc", for: indexPath) as! WorksCollectionCell

            // Las celdas restantes mostrarán los capítulos
            cell.C_CapTitle.text = chapter?.title
            cell.C_NumCap.text = "Chapter \(String(describing: chapter?.number))"
            cell.C_CapSummary.text = chapter?.summary ?? "No summary available"
            
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // Obtener el capítulo seleccionado
            guard let chapter = work?.chapters?[indexPath.row] else {
                print("Error: No se pudo obtener el capítulo.")
                return
            }

            // Instanciar la vista de contenido del capítulo
            if let chapterContentVC = storyboard?.instantiateViewController(withIdentifier: "content") as? ChapterContentViewController {
                // Pasar el contenido del capítulo a la nueva vista
                chapterContentVC.chapterTitle = chapter.title
                chapterContentVC.workTitle = work?.title
                chapterContentVC.chapterContent = chapter.content

                // Navegar a la vista de contenido del capítulo
                navigationController?.pushViewController(chapterContentVC, animated: true)
            }
        }
}

