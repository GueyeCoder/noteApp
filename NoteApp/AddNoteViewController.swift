//
//  AddNoteViewController.swift
//  NoteApp
//
//  Created by MAC on 04/06/2025.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    var note: Note?
    var update = false
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
   
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBAction func deleteClick(_ sender: Any) {
        print("Delete!")
        
        APIFunctions.functions.deleteNote(id: note!._id)
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func saveClick(_ sender: Any) {
        print("Save!")
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.string(from: Date())
        
        if update == true{
            APIFunctions.functions.updateNote(title: titleTextField.text!, note: bodyTextView.text!, date: date, id: note!._id)
        }else{
            APIFunctions.functions.addNote(title: titleTextField.text!, note: bodyTextView.text!, date: date)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if update == false {
            self.deleteButton.isEnabled = true
            self.deleteButton.title = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if update == true {
            titleTextField.text = note?.title
            bodyTextView.text = note?.note
        }
    }
}
