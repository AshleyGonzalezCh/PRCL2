//
//  ResultsViewController.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: SearchViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let work = viewModel.searchResults[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkCell", for: indexPath) as! WorksCollectionCell

        // Configura la celda con los datos de la obra
        cell.titulo?.text = work.title
        cell.lenguaje?.text = work.language
        cell.summary?.text = work.summary

        return cell
    }

    // Usamos `didSelectItemAt` en lugar de `didSelectRowAt`
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let work = viewModel.searchResults[indexPath.row]
        // Llamamos al segue para mostrar los detalles de la obra
        performSegue(withIdentifier: "showWorkDetail", sender: work)
    }

    // Preparar el segue con los datos de la obra seleccionada
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWorkDetail", let resultVC = segue.destination as? ResultsViewController {
            /*if let work = sender as? Work {
                resultVC.
            }*/
        }
    }
}


 
