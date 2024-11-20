//
//  ChapterContentVC.swift
//  PF
//
//  Created by alumno on 11/20/24.
//

import UIKit

class ChapterContentViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var T_Capitulo: UILabel!

    @IBOutlet weak var T_obra: UILabel!
    var chapterContent: String?
    var chapterTitle: String?
    var workTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        T_Capitulo.text = chapterTitle ?? "Untitled Chapter"
        T_obra.text = workTitle ?? "Untitled Work"
        
        //Estilo del contenido
        if let content = chapterContent {
            let formattedContent = content.replacingOccurrences(of: "\\n", with: "\n")
            contentTextView.text = formattedContent
        } else {
            contentTextView.text = "No content available"
        }

        
        contentTextView.font = UIFont.systemFont(ofSize: 16)
        contentTextView.textColor = .white
        contentTextView.backgroundColor = .black
        contentTextView.isEditable = false
        contentTextView.textAlignment = .justified
        contentTextView.isScrollEnabled = true
        contentTextView.translatesAutoresizingMaskIntoConstraints = false

    }
}

