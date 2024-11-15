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
        viewModel = WorkDetailViewModel()
        viewModel.work = work
        viewModel.loadChapters()

        collectionView.delegate = self
        collectionView.dataSource = self

        // Si estás usando un `UICollectionViewCell` personalizado, registra la celda aquí.
        // collectionView.register(UINib(nibName: "YourCellNibName", bundle: nil), forCellWithReuseIdentifier: "ChapterCell")
    }
}

extension WorkDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.chapters)
        guard let capitulos = viewModel.chapters else {
            return 0
        }
        return capitulos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chapter = viewModel.chapters![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCell", for: indexPath)
        
        // Si usas una celda personalizada, asegúrate de castear la celda correctamente.
        // Por ejemplo:
        // let customCell = cell as! YourCustomCell
        // customCell.configure(with: chapter)

        cell.contentView.subviews.compactMap { $0 as? UILabel }.first?.text = chapter.title
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chapter = viewModel.chapters![indexPath.row]
        // Aquí podrías agregar la lógica para manejar la selección del capítulo.
    }

    // Opcional: Configurar tamaño de celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Ajusta el tamaño según tu diseño
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 100)
    }
}

