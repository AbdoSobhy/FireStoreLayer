//
//  ViewController.swift
//  FireStoreLayer
//
//  Created by Abdelrahman Sobhy on 3/13/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view.
        
//        let mohamed = User(name: "ashraf", age: 22)
//        FirestoreServiceLayer.shared.create(mohamed, in: .Users)
//        FirestoreServiceLayer.shared.retreve(from: .Users, as: User.self) { users in
//            print(users)
//        var user = User(name: "7ambola", age: 15)
//        user.id = "vHoN05DNI2xVWVULTj2y"
//        FirestoreServiceLayer.shared.update(user, in: .Users)
//        
        var user = User(name: "7ambola", age: 15)
        user.id = "vHoN05DNI2xVWVULTj2y"
        FirestoreServiceLayer.shared.delete(user, from: .Users)
        }
    }




