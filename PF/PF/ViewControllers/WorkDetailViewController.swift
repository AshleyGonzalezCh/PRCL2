//
//  WorkDetailViewController.swift
//  PF
//
//  Created by alumno on 11/8/24.
//

import UIKit
 
class WorkDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var work: Work?
    var viewModel: WorkDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WorkDetailViewModel()
        viewModel.work = work
        viewModel.loadChapters()
        tableView.delegate = self
        tableView.dataSource = self
    }
}
 
extension WorkDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chapters!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chapter = viewModel.chapters![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterCell", for: indexPath)
        cell.textLabel?.text = chapter.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chapter = viewModel.chapters![indexPath.row]
        // Aquí podrías agregar la lógica para mostrar el contenido del capítulo, si es necesario.
    }
}
