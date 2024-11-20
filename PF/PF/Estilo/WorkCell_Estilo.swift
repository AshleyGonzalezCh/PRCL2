//
//  WorkCell_Estilo.swift
//  PF
//
//  Created by alumno on 11/19/24.
//

import UIKit

extension ResultsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 10 // Márgenes alrededor de cada celda
        let spacing: CGFloat = 20 // Espaciado entre celdas
        let columns: CGFloat = 1 // Número de columnas deseadas

        let totalSpacing = (margin * 2) + (spacing * (columns - 1))
        let itemWidth = (collectionView.frame.width - totalSpacing) / columns
        let itemHeight = itemWidth * 1.2 // Ajusta la altura como proporción del ancho

        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin: CGFloat = 10
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20 // Espaciado vertical entre filas
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20 // Espaciado horizontal entre columnas
    }
}

