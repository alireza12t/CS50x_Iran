//
//  NoteViewContoller.swift
//  Notes
//
//  Created by ali on 12/1/20.
//

import UIKit

class NoteViewContoller: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    
    var note: Note!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note.contents
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        note.contents = textView.text
        
        NoteManager.shared.save(note: note)
    }
    
    
}




