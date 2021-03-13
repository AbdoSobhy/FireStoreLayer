//
//  extenstion+documentFirestore.swift
//  FireStoreLayer
//
//  Created by Abdelrahman Sobhy on 3/13/21.
//

import Foundation
import FirebaseFirestore
enum DocumentSnapshotError: Error{
    case documentError
}

extension DocumentSnapshot {
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T{
        guard var documentJson = data() else {throw DocumentSnapshotError.documentError}
        if includingId {
            documentJson["id"] = documentID
        }
        let documentData = try JSONSerialization.data(withJSONObject: documentJson, options: [])
        let object = try JSONDecoder().decode(objectType, from: documentData)
        return object
    }
}
