//
//  uiDataViewModel.swift
//  Counter App
//
//  Created by Lucia Pettway on 5/1/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class uiDataViewModel: ObservableObject {
    
    @Published var uiTextNodes = [UIData]()
    
    let db = Firestore.firestore()
    
    func fetchData() {
        db.collection("UITextNodes").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.uiTextNodes = documents.map { (queryDocumentSnapshot) -> UIData in
                let data = queryDocumentSnapshot.data()
                let key = data["key"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                
                print(description)

                return UIData(description: description, key: key)
            }
        }
    }
}
