//
//  SearchViewController.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btn_buscar: UIButton!
    private let viewModel = SearchViewModel()
    
    // Nuevo flag para verificar si la búsqueda está en curso
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        // Configuración del botón de búsqueda
        btn_buscar.backgroundColor = .black
        btn_buscar.layer.borderColor = UIColor.white.cgColor
        btn_buscar.layer.borderWidth = 1.0
        btn_buscar.layer.cornerRadius = 8.0
        btn_buscar.clipsToBounds = true
        
        if #available(iOS 13.0, *) {
            let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
            searchTextField?.layer.borderWidth = 1.0
            searchTextField?.layer.borderColor = UIColor.white.cgColor
            searchTextField?.layer.cornerRadius = 8.0
            searchTextField?.clipsToBounds = true
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard !isSearching, let author = searchBar.text, !author.isEmpty else { return }

        // Establecer que la búsqueda está en curso
        isSearching = true

        // Limpia resultados previos antes de buscar
        viewModel.clearResults()
        
        // Deshabilita temporalmente el botón para evitar múltiples llamados
        btn_buscar.isEnabled = false

        viewModel.searchWorks(query: author) { [weak self] result in
            DispatchQueue.main.async {
                // Rehabilita el botón y marca la búsqueda como completada
                self?.btn_buscar.isEnabled = true
                self?.isSearching = false
                
                switch result {
                case .success(let works):
                    if works.isEmpty {
                        self?.showNoResultsAlert()
                    } else {
                        self?.performSegue(withIdentifier: "resultados", sender: nil)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    self?.showNoResultsAlert()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultados",
           let resultsVC = segue.destination as? ResultsViewController {
            resultsVC.viewModel = viewModel
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonTapped(UIButton()) // Activa el botón de búsqueda
    }
    
    func showNoResultsAlert() {
        let alert = UIAlertController(
            title: "No se encontraron resultados",
            message: "No se encontraron resultados para el autor ingresado. Por favor, intenta nuevamente.",
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(title: "Reintentar", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true) // Regresa a la pantalla anterior
        }
        
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
    }
}

