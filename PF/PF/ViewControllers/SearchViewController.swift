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
        
        if #available(iOS 13.0, *) {
            // Configura el borde del campo de texto de la barra de búsqueda
            let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
            searchTextField?.layer.borderWidth = 1.0 // Grosor del borde
            searchTextField?.layer.borderColor = UIColor.white.cgColor // Color del borde
            searchTextField?.layer.cornerRadius = 8.0 // Radio de los bordes (opcional)
            searchTextField?.clipsToBounds = true
        }

        
        
    }
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let author = searchBar.text, !author.isEmpty else { return }
        
        viewModel.searchWorks(query: author) { [weak self] result in
            switch result {
            case .success(let works): // Aquí obtenemos los resultados directamente
                DispatchQueue.main.async {
                    if works.isEmpty {
                        // No se encontraron resultados
                        self?.showNoResultsAlert()
                    } else {
                        // Navega a la pantalla de resultados
                        self?.performSegue(withIdentifier: "resultados", sender: nil)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error: \(error)")
                    self?.showNoResultsAlert() // Muestra alerta también en caso de error
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
            
            // Acción para reintentar
            let retryAction = UIAlertAction(title: "Reintentar", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true) // Regresa a la pantalla anterior
            }
            
            alert.addAction(retryAction)
            present(alert, animated: true, completion: nil)
        }
}
