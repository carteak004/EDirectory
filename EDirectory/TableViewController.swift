//
//  TableViewController.swift
//  EDirectory
//
//  Created by Kartheek chintalapati on 29/09/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //MARK: - Variable Declarations
    var employeeRecords = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployeeRecords()
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - User Defined function for fetching JSON Data
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
                        var i=0
                        for item in employeeJson
                        {
                            i = i+1
                            //print("coming in")
                            if let name = item["name"] as? [String:AnyObject]
                                //let gender = item["gender"] as? String, , let location = item["location"] as? [String], let email = item["email"] as? String, let dob = item["dob"] as? String, let phone = item["phone"] as? String, let cell = item["cell"] as? String, let pic = item["picture"] as? [String], let nat = item["nat"] as? String
                            {
                                //print("just")
                                //self.employeeRecords.append(Employee(gender: gender, name: name, location: location, email: email, dob: dob, phone: phone, cell: cell, thumbnailPic: pic[2], largePic: pic[0], nat: nat))
                                print(name)
                            }
                        }
                        print("goinf out for with i=\(i)")
                    }
                    self.tableView.reloadData()
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.employeeRecords.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! TableViewCell

        let employeeRecord = employeeRecords[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = "\(employeeRecord.name[0]). \(employeeRecord.name[1]) \(employeeRecord.name[2])"
        cell.emailLabel.text = employeeRecord.email
        cell.thumbnailPic.image = loadImage(imageUrl: employeeRecord.thumbnailPic)
        

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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
