//
//  ControladorPantallaCitas.swift
//  Boceto_1
//
//  Created by alumno on 9/23/24.
//

import Foundation
import UIKit


class ControladorPantallaCitas: UIViewController {

    @IBOutlet weak var nombre_de_quien_lo_dijo: UILabel!
    @IBOutlet weak var que_dijo_caja_texto: UILabel!
    
    var quien_lo_dijo: String
    var muroTexto: String

        required init?(coder: NSCoder) {
            self.muroTexto = ""
            self.quien_lo_dijo = ""
            
            super.init(coder: coder)

            print("Se cargó el default INIT")
        }
    
    init(muro_Texto: String, de_quien: String, coder: NSCoder){
        self.muroTexto = muro_Texto
        self.quien_lo_dijo = de_quien
            
        super.init(coder: coder)!
            

        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicializar_pantalla()
    }
    
    func inicializar_pantalla(){
        nombre_de_quien_lo_dijo.text = self.quien_lo_dijo
        que_dijo_caja_texto.text = self.muroTexto
    }
    
}
