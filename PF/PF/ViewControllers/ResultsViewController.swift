//
//  ResultsViewController.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: SearchViewModel! // Inyectado desde el controlador anterior

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func clearPreviousResults() {
        viewModel.searchResults.removeAll() // Limpia los resultados previos
        collectionView.reloadData() // Actualiza la vista de la colección
    }
}

extension ResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.searchResults.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else {
            return UICollectionViewCell() // Si viewModel es nil, devolvemos una celda vacía
        }

        let work = viewModel.searchResults[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkCell", for: indexPath) as! WorksCollectionCell

        cell.titulo?.text = work.title
        cell.lenguaje?.text = work.language
        cell.summary?.text = work.summary
        cell.status?.text = work.status

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }

        let work = viewModel.searchResults[indexPath.row]

        // Instanciar solo si aún no se ha empujado el controlador
        if self.navigationController?.topViewController is WorkDetailViewController {
            return
        }

        // Llamamos al método para navegar a la vista de detalles de la obra
        DispatchQueue.main.async {
            // Instanciar el controlador de vista de detalles
            if let pantallaDePublicacion = self.storyboard?.instantiateViewController(withIdentifier: "PantallaPublicacion") as? WorkDetailViewController {
                pantallaDePublicacion.work = work
                
                // Empujar el controlador de vista en el stack de navegación
                self.navigationController?.pushViewController(pantallaDePublicacion, animated: true)
            }
        }
    }
}

