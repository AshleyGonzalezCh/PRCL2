//
//  ControladorPantallaDelPost.swift
//  boceto_2_CellView
//
//  Created by Jadzia Gallegos on 10/10/24.
//

import UIKit

class ControladorPantallaDelPost: UIViewController {
    
    @IBOutlet weak var SeccionComentarios: UICollectionView!
    @IBOutlet weak var CuerpoTXT: UILabel!
    @IBOutlet weak var UsuarioTXT: UILabel!
    @IBOutlet weak var TituloTXT: UILabel!
    
    
    let proveedor_de_publicaciones = ProveedorDePublicaciones.autoreferencia
    
    public var id_publicacion: Int?
    private var publicacion: Post?
    private var usuario: Usuario?
    private var lista_comentarios : [Comentario] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hola mundo")

        // Do any additional setup after loading the view.
        
        
        let controlador_de_navegacion = self.navigationController as? mod_navegador_principal
                controlador_de_navegacion?.activar_navigation_bar(actviar: true)
        realizar_descarga_de_informacion()
    }
    
    func realizar_descarga_de_informacion(){
        if self.publicacion == nil{
            proveedor_de_publicaciones.obtener_publicaicon(id: self.id_publicacion ?? -1, que_hacer_al_recibir: {
                [weak self] (Post) in self?.publicacion = Post
                DispatchQueue.main.async {
                    self?.dibujar_publicacion()
                }
            })
        }
        
        else if self.publicacion != nil {
            proveedor_de_publicaciones.obtener_usuario(id: publicacion!.userId, que_hacer_al_recibir: {
                [weak self] (usuario) in self?.usuario = usuario
                DispatchQueue.main.async {
                    self?.dibujar_publicacion()
                }
            })
        }
        
    }

    func dibujar_publicacion(){
        guard let publicacion_actual = self.publicacion else{
            return
        }
        TituloTXT.text = publicacion_actual.title
        CuerpoTXT.text = publicacion_actual.body
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
