//
//  ResultsViewController.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import UIKit
 
class ResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: ResultsViewModel!

    override func viewDidLoad() {

        super.viewDidLoad()

        viewModel.loadWorks()

        tableView.delegate = self

        tableView.dataSource = self

    }

}
 
extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.works.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let work = viewModel.works[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCell", for: indexPath)

        cell.textLabel?.text = work.title

        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let work = viewModel.works[indexPath.row]

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

 
