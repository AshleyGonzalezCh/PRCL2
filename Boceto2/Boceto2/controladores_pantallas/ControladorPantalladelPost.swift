//
//  ControladorPantallaDelPost.swift
//  boceto_2_CellView
//
//  Created by Jadzia Gallegos on 10/10/24.
//

import UIKit

class ControladorPantallaDelPost: UIViewController {
    let proveedor_de_publicaciones = ProveedorDePublicaciones.autoreferencia
    
    public var id_publicacion: Int?
    private var publicacion: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hola mundo")

        // Do any additional setup after loading the view.
        
        
        let controlador_de_navegacion = self.navigationController as? mod_navegador_principal
                controlador_de_navegacion?.activar_navigation_bar(actviar: true)
        realizar_descarga_de_informacion()
    }
    
    func realizar_descarga_de_informacion(){
        proveedor_de_publicaciones.obtener_publicaicon(id: self.id_publicacion ?? -1, que_hacer_al_recibir: {
            [weak self] (Post) in self?.publicacion = Post
            DispatchQueue.main.async {
                self?.dibujar_publicacion()
            }
        })
    }

    func dibujar_publicacion(){
        print(publicacion?.body)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
