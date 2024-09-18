//
//  GenCitas.swift
//  Boceto_1
//
//  Created by alumno on 9/18/24.
//

import Foundation

class GeneradorDeCitas{
    var citas_Creadas: Array <cita>
    init(){
        citas_Creadas = []
    }
    func agregar_Cita(que_dijo: String, quien_lo_dijo: String){
        var cita_generada = cita(quien_lo_dijo: quien_lo_dijo, que_dijo: que_dijo)
        
        citas_Creadas.append(cita_generada)
    }
    
    func imprimirCita() -> cita{
        return citas_Creadas[0]
    }
}


var citas_de_IADA = GeneradorDeCitas()
//citas_de_IADA.agregar_Cita("Tengo hambre", quien_lo_dijo: "Todxs")
//print(citas_de_IADA.imprimirCita())
