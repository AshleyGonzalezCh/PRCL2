//
//  GenCitas.swift
//  Boceto_1
//
//  Created by alumno on 9/18/24.
//

import Foundation

class GeneradorDeCitas{
    var citas_creadas: Array<Cita>
    
    init(){
        citas_creadas = []
    }
    
    func agregar_cita(_ que_dijo: String, quien_lo_dijo: String){
        let cita_generada = Cita(quien_lo_dijo: quien_lo_dijo, que_dijo: que_dijo)
        
        citas_creadas.append(cita_generada)
    }
    
    
    func generar_citas_falsas(){
        self.agregar_cita("En las sombras, donde la oscuridad es mi única compañera, guardo un secreto explosivo. Un poder que podría cambiar el mundo, si tan solo tuviera el valor de liberarlo",
                     quien_lo_dijo: "Creeper"
        )
        
        self.agregar_cita("¡La vida es corta, ¡explota al máximo!",
                          quien_lo_dijo: "Creeper"
        )
        
        self.agregar_cita("GRrrrrr grrr grrr GRRRRR grrrgGRGRh",
                          quien_lo_dijo: "Zombie"
        )
        
        self.agregar_cita("Solia ser un explorador como tu... Pero me dieron con una flecha en la rodilla",
                          quien_lo_dijo: "Guardia"
        )
    }
    
}
