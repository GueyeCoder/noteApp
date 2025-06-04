//
//  ViewController.swift
//  NoteApp
//
//  Created by MAC on 03/06/2025.
//

import UIKit


protocol DataDelegate {
    func updateArray(array: String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notesArray = [Note]()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateNoteSegue"{
            let destinationVC = segue.destination as! AddNoteViewController
            if segue.identifier == "updateNoteSegue"{
                destinationVC.note = notesArray[noteTableView.indexPathForSelectedRow!.row]
                destinationVC.update = true
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCellTableViewCell
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date
        return cell
    }
    

    @IBOutlet weak var noteTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        APIFunctions.functions.getAllNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.getAllNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.getAllNotes()
        print(notesArray)
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }


}

extension ViewController: DataDelegate{
    func updateArray(array: String) {
        do {
            notesArray = try JSONDecoder().decode([Note].self, from: array.data(using: .utf8)!)
        }catch {
            print("Failed to decode")
        }
        self.noteTableView?.reloadData()
    }
}

