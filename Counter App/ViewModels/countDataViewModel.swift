//
//  uiDataViewModel.swift
//  Counter App
//
//  Created by Lucia Pettway on 5/1/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class countDataViewModel: ObservableObject {
    
    @Published var countData = [CountData]()
    
    let db = Firestore.firestore()
    
    func fetchData() {
        db.collection("count").addSnapshotListener(includeMetadataChanges: true) { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.countData = documents.map { (queryDocumentSnapshot) -> CountData in
                let data = queryDocumentSnapshot.data()
                let count = data["count"] as? Int ?? 0
                print(queryDocumentSnapshot)
                print(data)
                return CountData(count: count)
            }
        }
    }
    
    func updateData(value: Double) {
        db.collection("count").document("counterData").setData(["count": value], merge: true){ error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully merged!")
            }
        }
    }
}
