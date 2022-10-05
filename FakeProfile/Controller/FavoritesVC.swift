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
    var countryArray = [String]()
    var emailArray = [String]()
    var phoneArray = [String]()
    var adressArray = [String]()
    
    let tableview: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
        return tb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfile()
        configureTableView()
        configureViewController()
    }

    func configureViewController() {
        if nameArray.count == 0 {
            presentFPAlertOnMainThred(title: "Favorite Profiles not found",
                                      message: "Please go back and create random profile then click add favorites button",
                                      buttonTitle: "Ok")
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemBrown
        title = "Favorite Profiles"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.black;
        
    }
    func configureTableView() {
        view.addSubview(tableview)
        tableview.frame = view.bounds
        tableview.backgroundColor = .systemBrown
        tableview.dataSource = self
        tableview.delegate = self
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
        return CGFloat(self.tableview.frame.height/10)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destVC = FavoritesDetailVC()
        destVC.profileImage.image  = UIImage(data: imageArray[indexPath.row])
        destVC.nameLabel.text      = "  Name: \(nameArray[indexPath.row])"
        destVC.countryLabel.text   = "  Country: \(countryArray[indexPath.row])"
        destVC.emailLabel.text     = "  Email: \(emailArray[indexPath.row])"
        destVC.phoneLabel.text     = "  Phone: \(phoneArray[indexPath.row])"
        destVC.adressLabel.text    = "  Adress: \(adressArray[indexPath.row])"
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            
            self.deleteProfile(deleteObject: self.idArray[indexPath.row])
            self.idArray.remove(at: indexPath.row)
            self.nameArray.remove(at: indexPath.row)
            self.imageArray.remove(at: indexPath.row)
            self.countryArray.remove(at: indexPath.row)
            self.emailArray.remove(at: indexPath.row)
            self.phoneArray.remove(at: indexPath.row)
            self.adressArray.remove(at: indexPath.row)
            self.tableview.reloadData()
            print(self.nameArray)
            
        }
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: - CoreData
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
                let country = result.value(forKey: "country") as! String
                let email = result.value(forKey: "email") as! String
                let phone = result.value(forKey: "phone") as! String
                let adress = result.value(forKey: "adress") as! String
                nameArray.append(name)
                imageArray.append(data)
                idArray.append(id)
                countryArray.append(country)
                emailArray.append(email)
                phoneArray.append(phone)
                adressArray.append(adress)
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


