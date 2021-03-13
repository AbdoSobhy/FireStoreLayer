//
//  UsersViewController.swift
//  FireStoreLayer
//
//  Created by Abdelrahman Sobhy on 3/13/21.
//

import UIKit

class UsersViewController: UIViewController {
    @IBOutlet weak var usersTableView: UITableView!
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    @IBAction func addBtnWasPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add User", message: nil, preferredStyle: .alert)
        alert.addTextField { nameTF in
            nameTF.placeholder = "Name"
        }
        
        alert.addTextField { ageTF in
            ageTF.placeholder = "Age"
            ageTF.keyboardType = .numberPad
        }
        
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alert.textFields?.first?.text, let ageString = alert.textFields?.last?.text, let age = Int(ageString) else {return}
            let user = User(name: name, age: age)
            FirestoreServiceLayer.shared.create(user, in: .Users)
        }
        alert.addAction(add)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getUsers(){
        FirestoreServiceLayer.shared.retreve(from: .Users, as: User.self) { (users) in
            self.users = users
            self.usersTableView.reloadData()
        }
    }
}
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = String(users[indexPath.row].age)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user = users[indexPath.row]
        let alert = UIAlertController(title: "Update \(user.name)", message: nil, preferredStyle: .alert)
        alert.addTextField { ageTF in
            ageTF.placeholder = "Age"
            ageTF.keyboardType = .numberPad
        }
        let update = UIAlertAction(title: "Update", style: .default) { _ in
            guard let ageString = alert.textFields?.last?.text, let age = Int(ageString) else {return}
            user.age = age
            FirestoreServiceLayer.shared.update(user, in: .Users)
        }
        alert.addAction(update)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = users[indexPath.row]
            FirestoreServiceLayer.shared.delete(user, from: .Users)
        }
    }
    
    
}




