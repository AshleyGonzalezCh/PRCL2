//
//  ControladorPantallaPrincipal.swift
//  Boceto2
//
//  Created by alumno on 10/7/24.
//

import UIKit



class ControladorPantallaPrincipal: UICollectionViewController {
    
    private let ID_celda = "cpp"
    private var lista_de_publicaciones: [Post] = []
    let proveedor_de_publicaciones = ProveedorDePublicaciones.autoreferencia
    
    //private let ID_celda = "celdas_pantalla_principal"
    override func viewDidLoad() 
        {
        super.viewDidLoad()
            proveedor_de_publicaciones.obtener_publicaicones(que_hacer_al_recibir: {
                [weak self] (Publicaciones) in self?.lista_de_publicaciones = Publicaciones
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            })
        }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print("Se selecciono la celda\(indexPath)")
           
           let pantalla_de_publicacion = storyboard?.instantiateViewController(withIdentifier: "PantallaPublicacion") as! ControladorPantallaDelPost
        
        pantalla_de_publicacion.id_publicacion = self.lista_de_publicaciones[indexPath.item].id
        
           
           self.navigationController?.pushViewController(pantalla_de_publicacion, animated: true)
           
           //print(self.navigationController)

       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.lista_de_publicaciones.count
    }

    //Función para odentofocar u crear cada una de las celdas creadas en el controlador
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda : Clase_Vista_Celda = collectionView.dequeueReusableCell (withReuseIdentifier: ID_celda, for: indexPath) as! Clase_Vista_Celda
    
        // Configure the cell
        //CAMBIAR COLOR DE LA CELDA
        //celda.backgroundColor = UIColor.red
        celda.EtiquetaText.text = self.lista_de_publicaciones[indexPath.item].title
        celda.CuerpoText.text = self.lista_de_publicaciones[indexPath.item].body
        //print(self.lista_de_publicaciones[indexPath.item].title)
        return celda
    }
    
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
