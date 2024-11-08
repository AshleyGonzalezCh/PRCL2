//
//  SearchViewController.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import UIKit
 
class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    private let viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let author = searchBar.text, !author.isEmpty else { return }
        // Llama al ViewModel para hacer la búsqueda solo por autor
        viewModel.searchWorks(author: author) { [weak self] result in
            switch result {
            case .success(_):
                self?.performSegue(withIdentifier: "showResults", sender: nil)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults",
           let resultsVC = segue.destination as? ResultsViewController {
            resultsVC.viewModel = viewModel
        }
    }
}
 
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonTapped(UIButton()) // Activa el botón de búsqueda
    }
}
