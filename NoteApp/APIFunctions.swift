//
//  APIFunctions.swift
//  NoteApp
//
//  Created by MAC on 04/06/2025.
//


import Foundation
import Alamofire

struct Note: Decodable{
    var _id: String
    var title: String
    var note: String
    var date: String
    
}

class APIFunctions {
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func getAllNotes(){
        AF.request("http://192.168.1.15:8081/getAll").response{ response in
            print(response.data!)
            
            let data = String(data: response.data!, encoding: .utf8)
            
            self.delegate?.updateArray(array: data!)
        }
    }
    
    func addNote(title: String, note: String, date: String){
        AF.request("http://192.168.1.15:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "note": note, "date": date]).responseJSON{ response in
            print(response)
        }
    }
    
    func updateNote(title: String, note: String, date: String, id: String){
        AF.request("http://192.168.1.15:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "note": note, "date": date, "id":id]).responseJSON{ response in
            print(response)
        }
        
    }
    
    func deleteNote(id: String){
        AF.request("http://192.168.1.15:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: ["id":id]).responseJSON{ response in
            print(response)
        }
        
    }
}
