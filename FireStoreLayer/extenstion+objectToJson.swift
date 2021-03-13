//
//  extenstion+objectToJson.swift
//  FireStoreLayer
//
//  Created by Abdelrahman Sobhy on 3/13/21.
//

import Foundation
extension Encodable {
    func toJson(excluding keys: [String] = []) -> [String: Any] {
    guard let objectData = try? JSONEncoder().encode(self) else {return [:]}
        guard var json = try? JSONSerialization.jsonObject(with: objectData, options: []) as? [String: Any] else {return [:]}
        for key in keys {
            json[key] = nil
        }
        return json
    }
}
