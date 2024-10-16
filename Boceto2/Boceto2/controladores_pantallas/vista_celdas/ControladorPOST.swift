//
//  ControladorPOST.swift
//  Boceto2
//
//  Created by alumno on 10/16/24.
//

import UIKit

private let ID_celdaPOST = "Celda_Pantalla_Post"

class ControladorPantallaPublicacion: UICollectionViewController {
    private var Contenido_Post: [Post] = []
    private let url_de_publicaciones = "https://jsonplaceholder.typicode.com/posts"
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.Contenido_Post.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda : Clase_Vista_Celda = collectionView.dequeueReusableCell (withReuseIdentifier: ID_celdaPOST, for: indexPath) as! Clase_Vista_Celda
    
        // Configure the cell
        //CAMBIAR COLOR DE LA CELDA
        //celda.backgroundColor = UIColor.red
        celda.EtiquetaText.text = self.Contenido_Post[indexPath.item].title
        celda.CuerpoText.text = self.Contenido_Post[indexPath.item].body
        print(self.Contenido_Post[indexPath.item].title)
        return celda
    }
}
