//
//  EstilosCellViewComentarios.swift
//  Boceto2
//
//  Created by alumno on 10/28/24.
//
import UIKit
extension ControladorPantallaDelPost: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var ancho = self.SeccionComentarios.frame.width
        var largo = self.SeccionComentarios.frame.height
        ancho = ancho / 4
        largo = largo / 4
        
        return CGSize(width: ancho, height: largo)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let margin = CGFloat(5)
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            var ancho = self.SeccionComentarios.frame.width
            ancho = ancho / 5
            
            return ancho
        }
}
