//
//  DetailViewController.swift
//  EDirectory
//
//  Created by ta on 10/4/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Variable Declaration
    var sentThumbnail:String!
    var sentLarge:String!
    var sentName:String!
    var sentCell:String!
    var sentPhone:String!
    var sentEmail:String!
    var sentAddress:String!
    var sentDob:String!
    var sentGender:String!
    var sentRegDate:String!
    
    //MARK: - Outlets
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellButtonLabel: UIButton!
    @IBOutlet weak var phoneButtonLabel: UIButton!
    @IBOutlet weak var emailButtonLabel: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var birthdayButtonLabel: UIButton!
    @IBOutlet weak var hiredDateButtonLabel: UIButton!
    @IBOutlet weak var genderLabel: UILabel!
    
    //MARK: - Actions
    @IBAction func largeImageViewButton(_ sender: UIButton) {
    
    }
    
    @IBAction func callButton(_ sender: UIButton) {
        // Create the AlertController and add its actions like button in ActionSheet
        let actionSheetController = UIAlertController(title: "📞 Call", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let cellButton = UIAlertAction(title: "Cell: \(sentCell!)", style: .default) { action -> Void in
            let myURL:NSURL = URL(string: "tel://\(self.sentCell!)")! as NSURL
            UIApplication.shared.open(myURL as URL, options: [:], completionHandler: nil)
            
            // Display the simple alert since we cannot test the above
            // code on the simulator
            let alertController = UIAlertController(title: "Calling..", message: "\(self.sentCell!)", preferredStyle: .alert)
            
            let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
                
                (alert: UIAlertAction!) -> Void in
            })
            alertController.addAction(dismissButton)
            self.present(alertController, animated: true, completion: nil)
        }
        actionSheetController.addAction(cellButton)
        
        let phoneButton = UIAlertAction(title: "Phone: \(sentPhone)", style: .default) { action -> Void in
            let myURL:NSURL = URL(string: "tel://\(self.sentPhone!)")! as NSURL
            UIApplication.shared.open(myURL as URL, options: [:], completionHandler: nil)
            
            // Display the simple alert since we cannot test the above
            // code on the simulator
            let alertController = UIAlertController(title: "Calling..", message: "\(self.sentPhone!)", preferredStyle: .alert)
            
            let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
                
                (alert: UIAlertAction!) -> Void in
            })
            alertController.addAction(dismissButton)
            self.present(alertController, animated: true, completion: nil)
        }
        actionSheetController.addAction(phoneButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func textButton(_ sender: UIButton) {
    }
    
    @IBAction func topEmailButton(_ sender: UIButton) {
    }
    
    @IBAction func cellButton(_ sender: UIButton) {
    }
    
    @IBAction func phoneButton(_ sender: UIButton) {
    }
   
    @IBAction func emailButton(_ sender: UIButton) {
    }
    
    @IBAction func birthdayButton(_ sender: UIButton) {
    }
    
    @IBAction func hiredDateButton(_ sender: UIButton) {
    }
    
    let homeView = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Loading Labels and Images
        thumbnailView.image = homeView.loadImage(imageUrl: sentThumbnail)
        nameLabel.text = sentName
        cellButtonLabel.setTitle(sentCell, for: .normal)
        phoneButtonLabel.setTitle(sentPhone, for: .normal)
        emailButtonLabel.setTitle(sentEmail, for: .normal)
        addressLabel.text = sentAddress
        birthdayButtonLabel.setTitle(sentDob, for: .normal)
        hiredDateButtonLabel.setTitle(sentRegDate, for: .normal)
        genderLabel.text = sentGender
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
