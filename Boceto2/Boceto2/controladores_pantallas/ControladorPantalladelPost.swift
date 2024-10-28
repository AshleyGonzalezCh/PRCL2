//
//  ControladorPantallaDelPost.swift
//  boceto_2_CellView
//
//  Created by Jadzia Gallegos on 10/10/24.
//

import UIKit

class ControladorPantallaDelPost: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var SeccionComentarios: UICollectionView!
    @IBOutlet weak var CuerpoTXT: UILabel!
    @IBOutlet weak var UsuarioTXT: UILabel!
    @IBOutlet weak var TituloTXT: UILabel!
    
    
    let proveedor_de_publicaciones = ProveedorDePublicaciones.autoreferencia
    private let identificador_de_celda = "celda_comentario"
    
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
        
        SeccionComentarios.dataSource = self
        realizar_descarga_de_informacion()
    }
    
    func realizar_descarga_de_informacion(){
        if self.publicacion == nil{
            proveedor_de_publicaciones.obtener_publicaicon(id: self.id_publicacion ?? -1, que_hacer_al_recibir: {
                [weak self] (Post) in self?.publicacion = Post
                DispatchQueue.main.async {
                    self?.dibujar_publicacion()
                    self?.realizar_descarga_de_informacion()
                }
            })
        }
        
        else if self.publicacion != nil {
            proveedor_de_publicaciones.obtener_usuario(id: publicacion!.userId, que_hacer_al_recibir: {
                [weak self] (usuario) in self?.usuario = usuario
                DispatchQueue.main.async {
                    self?.dibujar_usuario()
                }
            })
            
            proveedor_de_publicaciones.obtener_comentarios_en_publicacion(id: publicacion!.id, que_hacer_al_recibir: {
                [weak self] (comentarios_descargados) in self?.lista_comentarios = comentarios_descargados
                DispatchQueue.main.async {
                    self?.SeccionComentarios.reloadData()
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
    
    func dibujar_usuario(){
        guard let usuario_actual = self.usuario else {
            return
        }
        
        UsuarioTXT.text = usuario_actual.username
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lista_comentarios.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Aqui deberia hacer algo")
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: identificador_de_celda, for: indexPath) as! Clase_Vista_Celda
    
        // Configure the cell
        celda.tintColor = UIColor.green
  
        // print(self.lista_de_publicaciones)
        
        celda.UsernameComentario.text = self.lista_comentarios[indexPath.item].name
        celda.Email.text = self.lista_comentarios[indexPath.item].email
        celda.Comentarios.text = self.lista_comentarios[indexPath.item].body
        
        return celda
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
