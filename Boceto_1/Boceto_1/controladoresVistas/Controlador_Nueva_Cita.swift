//
//  Controlador_Nueva_Cita.swift
//  Boceto_1
//
//  Created by alumno on 9/27/24.
//

import UIKit

class ControladorGeneradorCita: UIViewController{
    @IBOutlet weak var NuevaCitaBTN: UIButton!
    @IBOutlet weak var Quien_Lo_Dijo_txt: UITextField!
    @IBOutlet weak var Que_Dijo_txt: UITextField!
    var quien_lo_dice: String = ""
    var que_dice: String = ""
    var cita_creada: Cita? = nil
    
    @IBAction func agregar_cita_nueva(_ sender: UIButton) {
            cita_creada = Cita(quien_lo_dijo: Quien_Lo_Dijo_txt.text!,
                               que_dijo: Que_Dijo_txt.text!)
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
}
