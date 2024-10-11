//
//  EstiloCellViewController.swift
//  Boceto2
//
//  Created by alumno on 10/11/24.
//

import UIKit
extension ControladorPantallaPrincipal: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var ancho = self.collectionView.frame.width
        var largo = self.collectionView.frame.height
        ancho = ancho/3.5
        largo = ancho * 0.5
        
        return CGSize(width: ancho, height: largo)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var margin = CGFloat(10)
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, minimunLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, minimumInteritSpacingForSectionAt section: Int) -> CGFloat {
        var ancho = self.collectionView.frame.width
        ancho = ancho/3.5
        return 5
    }
}
