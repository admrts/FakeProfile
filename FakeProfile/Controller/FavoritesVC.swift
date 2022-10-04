//
//  FavoritesVC.swift
//  FakeProfile
//
//  Created by Ali Demirtaş on 4.10.2022.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var profiles = [FavoriteProfile]()
    
    var nameArray = [String]()
    var imageArray = [Data]()
    var idArray = [UUID]()
    
    let tableview: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
        return tb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfile()
        view.backgroundColor = .systemBackground
        configureTableView()
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    
    
    func configureTableView() {
        view.addSubview(tableview)
        tableview.frame = view.bounds
    }
}

extension FavoritesVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID, for: indexPath) as! FavoritesCell
        cell.nameLabel.text =  nameArray[indexPath.row]
        let data = imageArray[indexPath.row]
        cell.profileImage.image = UIImage(data: data)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(idArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            DispatchQueue.main.async {
                self.deleteProfile(deleteObject: self.idArray[indexPath.row])
                self.loadProfile()
                self.tableview.reloadData()
                print(self.nameArray)
            }
        }
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension FavoritesVC {
    func loadProfile() {
        nameArray.removeAll()
        imageArray.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteProfile")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            for result in results  {
                let name = result.value(forKey: "name") as! String
                let data = result.value(forKey: "picture") as! Data
                let id = result.value(forKey: "id") as! UUID
        
                nameArray.append(name)
                imageArray.append(data)
                idArray.append(id)
            }
            tableview.reloadData()
        }catch {
            print("Loading failed \(error)")
        }
        
    }
    func deleteProfile(deleteObject: UUID){
           let idString = deleteObject.uuidString

           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteProfile")
           request.predicate = NSPredicate(format: "id = %@", idString)
           do {
               let results = try context.fetch(request)
               for result in results as! [NSManagedObject] {
                   context.delete(result)
                   try context.save()
               }
           }catch {
               print("Delete error \(error)")
           }
       }
}


