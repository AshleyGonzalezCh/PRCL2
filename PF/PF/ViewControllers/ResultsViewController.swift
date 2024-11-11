//
//  ResultsViewController.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import UIKit
 
class ResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UICollectionView!

    var viewModel: SearchViewModel!

    override func viewDidLoad() {

        super.viewDidLoad()

        tableView.delegate = self

        tableView.dataSource = self

    }

}
 
extension ResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let work = viewModel.searchResults[indexPath.row]

        let cell = tableView.dequeueReusableCell(withReuseIdentifier: "WorkCell", for: indexPath) as! WorksCollectionCell

        cell.titulo?.text = work.title
        cell.lenguaje?.text = work.language
        cell.summary?.text = work.summary
        cell.word_count?.text = String(work.word_count)

        return cell
    }
    


    func tableView(_ tableView: UICollectionView, didSelectRowAt indexPath: IndexPath) {

        let work = viewModel.searchResults[indexPath.row]

        // Llamar a la siguiente pantalla para mostrar los detalles de la obra

        performSegue(withIdentifier: "showWorkDetail", sender: work)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showWorkDetail", let workDetailVC = segue.destination as? WorkDetailViewController {

            if let work = sender as? Work {

                workDetailVC.work = work

            }

        }

    }

}

 
