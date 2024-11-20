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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        // Fondo negro
        btn_buscar.backgroundColor = .black
            
            // Borde blanco
        btn_buscar.layer.borderColor = UIColor.white.cgColor
        btn_buscar.layer.borderWidth = 1.0

            // Redondear bordes (opcional)
        btn_buscar.layer.cornerRadius = 8.0 // Ajusta según tus necesidades
        btn_buscar.clipsToBounds = true
    }
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let author = searchBar.text, !author.isEmpty else { return }
        // Llama al ViewModel para hacer la búsqueda solo por autor
        viewModel.searchWorks(query: author) { [weak self] result in
            switch result {
            case .success(_):
                // Asegúrate de realizar el segue en el hilo principal
                DispatchQueue.main.async {
                    self?.performSegue(withIdentifier: "resultados", sender: nil)
                }
            case .failure(let error):
                print("Error: \(error)")
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
}
