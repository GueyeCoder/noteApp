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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
     //   cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var noteTableView: UITableView!
    
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
    }
}

