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
    
    var cita_actual: Cita

    required init?(coder: NSCoder) {
        self.cita_actual = Cita(quien_lo_dijo: "Desarrollador", que_dijo: "Tenemos 1problema chikis")
        super.init(coder: coder)
        print("Se cargó el default INIT")
        }
    
    init?(cita_para_citar: Cita, coder: NSCoder){
           self.cita_actual = cita_para_citar
           super.init(coder: coder)
       }
       
    
    
    
   /*/ init(muro_Texto: String, de_quien: String, coder: NSCoder){
        self.muroTexto = muro_Texto
        self.quien_lo_dijo = de_quien
            
        super.init(coder: coder)!
        }
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicializar_pantalla()
    }
    
    func inicializar_pantalla(){
        nombre_de_quien_lo_dijo.text = cita_actual.nombre
        que_dijo_caja_texto.text = cita_actual.texto
    }
    
}
