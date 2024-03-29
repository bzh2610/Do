//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//
import CoreData
import UIKit

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var meals = [Reminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeals()
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reloadTableView),
                                               name: NSNotification.Name(rawValue: "reloadTableView"),
                                               object: nil)
        
        
    }
    
    @objc func reloadTableView(){
        loadSampleMeals()
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
     
       

        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
      //  cell.content = Reminder.content
        
        cell.nameLabel.text = meal.content
  
      //  cell.photoImageView.image = meal.photo
       // cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     //MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: Private Methods
    
    public func loadSampleMeals() {
        
        /*
         
         APPLE EXAMPLE
         
         
         
         let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }
        
        meals += [meal1, meal2, meal3]*/
        
        
        
        
        
        
        
        
        /*CORE DATA*/
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        /*INSERT*/
        
        
        
        
        /*CODE FONCTIONNEL, INSERE DANS LA CORE DATA*/
        
        
        /*
         if let bd =  NSEntityDescription.insertNewObject(forEntityName: "Reminder", into: moc) as? Reminder {
         
         bd.content="🍉"
         
         do {
         try moc.save()
         
         } catch {
         print("unable to add reminder\(error)")
         
         }
         
         }
        */
        
        /*FETCH*/
        
        var locations  = [Reminder]() // Where Locations = your NSManaged Class
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        // locations = try moc.fetch(fetchRequest) as! [Reminder]
        do {
            meals = try moc.fetch(fetchRequest) as! [Reminder]
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        
        /*for location in locations {
         
         print(location.content)
         
         }*/
        
    }
    
}

