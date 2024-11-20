//
//  WorkDetailViewController.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import UIKit

class WorkDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var work: Work?
    var viewModel: WorkDetailViewModel!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            print("--------")
            print("\(work?.chapters)")
            print("\(type(of: work))")
            print("--------")
            
            
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
        }
    }

    extension WorkDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return work?.chapters?.count ?? 0
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let chapter = work?.chapters?[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cc", for: indexPath) as! WorksCollectionCell

            if indexPath.row == 0 {
                // La primera celda será para mostrar los detalles del trabajo
                cell.C_Titulo.text = chapter!.title
                cell.C_Summary.text = chapter!.summary
                cell.C_Lenguaje.text = self.work?.language
            }
                else {
                // Las celdas restantes mostrarán los capítulos
                    cell.C_CapTitle.text = chapter?.title
                    cell.C_NumCap.text = "Chapter \(String(describing: chapter?.number))"
                    cell.C_CapSummary.text = chapter?.summary ?? "No summary available"
                    
                    print("--------")
                    print("\(String(describing: work))")
                    print("\(type(of: work))")
                    print("--------")
            }
            
            return cell
        }


        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Ajusta el tamaño según tu diseño
            return CGSize(width: collectionView.frame.width / 2 - 10, height: 100)
        }
}

