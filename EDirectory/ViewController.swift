//
//  ViewController.swift
//  EDirectory
//
//  Created by ta on 10/6/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    //MARK: - Variable Declarations
    var employeeRecords = [Employee]()
    var filteredEmployees = [Employee]() //to store search results
    var inactiveQueue:DispatchQueue!

    
    //@IBOutlet weak var searchController: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    //This is to let the controller know that I am using the same View Controller to show the search results.
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let queue = inactiveQueue
        {
            queue.activate()
        }
        
        let queueX = DispatchQueue(label: "edu.niu.cs.queueX")
        queueX.sync {
            fetchEmployeeRecords()
        }
        filteredEmployees = employeeRecords //initialising filteredEmployees object with employeeRecords object
        
        //MARK: SEARCH BAR RELATED
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating       //This will let the class be informed of any text changes in the search bar
        searchController.dimsBackgroundDuringPresentation = false   //This will not let the view controller get dim when a search is performed.
        definesPresentationContext = true   //this will make sure that the search bar will not be active in other screens
        tableView.tableHeaderView = searchController.searchBar  //This will add the search bar to table header view

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - User Defined functions
    
    //This functions fetches json data and stores it into a employeeRecords object.
    func fetchEmployeeRecords()
    {
        let apiUrl = URL(string: "http://faculty.cs.niu.edu/~krush/ios/edirectory_json") // create URL Variable
        let urlRequest = URLRequest(url: apiUrl!)
        
        //submit a request to fetch data
        let task = URLSession.shared.dataTask(with: urlRequest)
        {
            (data,response,error) in
            //if there is an error, print it onto console and don't continue
            if error != nil {
                print(error!)
                return
            }
            
            //if there is no error, fetch json content
            if let content = data
            {
                do
                {
                    let jsonObject = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    //fetch required data
                    if let employeeJson = jsonObject["results"] as? [[String:AnyObject]] {
                        //var i=0
                        for item in employeeJson
                        {
                            // i = i+1
                            //print("coming in")
                            if let name = item["name"] as? [String:AnyObject], let gender = item["gender"] as? String, let location = item["location"] as? [String:AnyObject], let email = item["email"] as? String, let dob = item["dob"] as? String, let phone = item["phone"] as? String, let cell = item["cell"] as? String, let pic = item["picture"] as? [String:AnyObject], let nat = item["nat"] as? String, let regDate = item["registered"] as? String
                            {
                                //print("just")
                                self.employeeRecords.append(Employee(gender: gender, name: "\(name["first"]!) \(name["last"]!)", location: location, email: email, dob: dob, phone: phone, cell: cell, thumbnailPic:pic["thumbnail"] as! String, largePic:pic["large"] as! String, nameTitle:"\(name["title"]!)", nat:nat, regDate:regDate))
                                //print(pic["large"]!, pic["thumbnail"]!)
                                //print("\(name["first"]!) \(name["last"]!)")
                                //print(self.employeeRecords[0].name)
                                
                            }
                        }
                        //print("goinf out for with i=\(i)")
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch
                {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    //Function to load image from URL in a imageView. It takes the url as input and returns UIImage
    func loadImage(imageUrl:String) -> UIImage
    {
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        
        return UIImage(data: data!)!
    }
    
    //This function returns the filtered data
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredEmployees = employeeRecords.filter { item in
            return item.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //This will show the search results if the search bar is active and something is typed into it or displays all the cells if no search is performed.
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredEmployees.count
        }
        return employeeRecords.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! TableViewCell
        
        let employeeRecord:Employee!
        if searchController.isActive && searchController.searchBar.text != ""
        {
            employeeRecord = filteredEmployees[indexPath.row]
        }
        else
        {
            employeeRecord = employeeRecords[indexPath.row]
        }
        
        // Configure the cell...
        cell.nameLabel.text = "\(employeeRecord.nameTitle!). \(employeeRecord.name!)"
        cell.emailLabel.text = employeeRecord.email
        cell.thumbnailPic.image = loadImage(imageUrl: employeeRecord.thumbnailPic)
        
        
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"
        {
            let detailVC = segue.destination as! DetailViewController
            
            //Data to be sent over Segue
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                
                let employeeRecord:Employee!
                
                if searchController.isActive && searchController.searchBar.text != ""
                {
                    employeeRecord = filteredEmployees[indexPath.row]
                }
                else
                {
                    employeeRecord = employeeRecords[indexPath.row]
                }
                
                
                detailVC.sentThumbnail = employeeRecord.thumbnailPic
                detailVC.sentName = "\(employeeRecord.nameTitle!). \(employeeRecord.name!)"
                detailVC.sentCell = employeeRecord.cell
                detailVC.sentPhone = employeeRecord.phone
                detailVC.sentEmail = employeeRecord.email
                detailVC.sentAddress = "\(employeeRecord.location["street"] as! String)\n\(employeeRecord.location["city"] as! String)\n\(employeeRecord.location["state"] as! String) - \(employeeRecord.location["postcode"]!)\n\(employeeRecord.nat!)"
                detailVC.sentDob = employeeRecord.dob
                detailVC.sentGender = employeeRecord.gender
                detailVC.sentRegDate = employeeRecord.regDate
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}

/// This class extension allows the table view controller to respond to search bar by implementing UISearchResultsUpdating.
extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
