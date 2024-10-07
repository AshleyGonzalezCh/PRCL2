//
//  ViewController.swift
//  Boceto_1
//
//  Created by alumno on 9/18/24.
//

import UIKit

class ViewController: UIViewController {
    var citas_disponiblea: GeneradorDeCitas = GeneradorDeCitas()
    var cita_para_enviar: Cita = Cita(quien_lo_dijo: "Elon Musk", que_dijo: "Monimonimoni")
    
    override func viewDidLoad() {
        citas_disponiblea.generar_citas_falsas()
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
    }
    
    @IBSegueAction func al_abrir_pantalla_citas(_ coder: NSCoder) -> ControladorPantallaCitas? {
        return ControladorPantallaCitas(cita_para_citar: citas_disponiblea.obtener_cita(), coder: coder)
    }
    
    @IBAction func voler_a_pantalla_inicio(segue: UIStoryboardSegue){
            if let pantalla_agregar_citas = segue.source as? ControladorGeneradorCita{
                citas_disponiblea.agregar_cita(pantalla_agregar_citas.cita_creada!)
            }
            
        }
    


}

