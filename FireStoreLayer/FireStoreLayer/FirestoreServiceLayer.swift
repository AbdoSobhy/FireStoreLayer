//
//  FirestoreServiceLayer.swift
//  FireStoreLayer
//
//  Created by Abdelrahman Sobhy on 3/13/21.
//

import Foundation
import Firebase

class FirestoreServiceLayer {
    private init () { }
    static let shared = FirestoreServiceLayer()
    
    func firestoreConfugeration() {
        FirebaseApp.configure()
    }
    
    private func ref(to id: FirestoreCollections) -> CollectionReference{
        return Firestore.firestore().collection(id.rawValue)
    }
    
    func create<T: Encodable>(_ object: T, in collection: FirestoreCollections){
        do {
            let json = try object.toJson(excluding: ["id"])
            ref(to: collection).addDocument(data: json)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retreve<T: Decodable>(from collection: FirestoreCollections, as type: T.Type, completionHandler: @escaping ([T])-> Void) {
        ref(to: collection).addSnapshotListener { snapShot, error in
            guard let snapShot = snapShot else {return}
            do{
                var objects = [T]()
                for document in snapShot.documents{
                    objects.append(try document.decode(as: type))
                }
                completionHandler(objects)
            } catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func update<T: Encodable & Identifiable>(_ encodedObject: T,in collection: FirestoreCollections){
        guard let docId = encodedObject.id as? String else {return}
        do {
            let json = try encodedObject.toJson(excluding: ["id"])
            ref(to: collection).document(docId).setData(json)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete<T: Identifiable>(_ identifiableObject: T, from collection: FirestoreCollections) {
        guard let docId = identifiableObject.id as? String else {return}
        ref(to: collection).document(docId).delete()
    }
    
    
}
