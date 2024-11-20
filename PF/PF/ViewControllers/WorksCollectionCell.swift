//
//  WorksCollectionCell.swift
//  PF
//
//  Created by alumno on 11/11/24.
//

import UIKit

class WorksCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var lenguaje: UILabel!
    @IBOutlet weak var titulo: UILabel!
    
    //WorkDetail
    
    @IBOutlet weak var C_CapTitle: UILabel!
    @IBOutlet weak var C_NumCap: UILabel!
    @IBOutlet weak var C_CapSummary: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    private func setupStyle() {
        // Establece un borde
        self.layer.borderColor = UIColor.white.cgColor // Cambia a cualquier color
        self.layer.borderWidth = 0.5 // Ancho del borde

        // Opcional: Redondear las esquinas
        self.layer.cornerRadius = 8.0 // Cambia según lo que desees

        // Opcional: Agregar una sombra para resaltar las celdas
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 4.0

        // Asegúrate de que el contenido de la celda esté dentro de los bordes redondeados
        self.layer.masksToBounds = false
    }
    
    
    
}
