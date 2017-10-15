//
//  DetailViewController.swift
//  EDirectory
//
//  Created by ta on 10/4/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    //MARK: - Variable Declaration
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
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var hiredLabel: UILabel!
    
    //MARK: - Actions
    
    @IBAction func callButton(_ sender: UIButton) {
        // Create the AlertController and add its actions like button in ActionSheet
        let actionSheetController = UIAlertController(title: "📞 Call", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) 
        actionSheetController.addAction(cancelActionButton)
        
        let cellButton = UIAlertAction(title: "Cell: \(sentCell!)", style: .default) { action -> Void in
            self.callANumber(number: self.sentCell!)
        }
        actionSheetController.addAction(cellButton)
        
        let phoneButton = UIAlertAction(title: "Phone: \(sentPhone!)", style: .default) { action -> Void in
            self.callANumber(number: self.sentPhone!)
        }
        actionSheetController.addAction(phoneButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func textButton(_ sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [sentCell]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        else{
            let alertController = UIAlertController(title: "OOPS!", message: "This functionality is not allowed in a Simulator", preferredStyle: .alert)
            
            let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
                
                (alert: UIAlertAction!) -> Void in
            })
            alertController.addAction(dismissButton)
            self.present(alertController, animated: true, completion: nil)

        }
    }
    
    @IBAction func topEmailButton(_ sender: UIButton) {
        sendAnEMail()
    }
    
    @IBAction func cellButton(_ sender: UIButton) {
        callANumber(number: sentCell!)
    }
    
    @IBAction func phoneButton(_ sender: UIButton) {
        callANumber(number: sentPhone!)
    }
   
    @IBAction func emailButton(_ sender: UIButton) {
        sendAnEMail()
    }
    
    
    
    let homeView = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Loading Labels and Images
        self.title = sentName
        
        thumbnailView.image = homeView.loadImage(imageUrl: sentLarge)
        homeView.setCircularImage(imageView: thumbnailView)
        cellButtonLabel.setTitle(sentCell, for: .normal)
        phoneButtonLabel.setTitle(sentPhone, for: .normal)
        emailButtonLabel.setTitle(sentEmail, for: .normal)
        addressLabel.text = sentAddress
        birthdayLabel.text = changeDate(dateString: sentDob)
        hiredLabel.text = changeDate(dateString: sentRegDate)
        genderLabel.text = sentGender
        
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    //MARK - User defined functions
    
    //function for call button. When the button is pressed, it will disply the calling alert.
    func callANumber(number: String)
    {
        let stringURL = "tel://\(number)"
        //let myURL:NSURL = URL(string: "tel://\(number)")! as NSURL
        let myURL:NSURL = URL(string: stringURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)! as NSURL
        UIApplication.shared.open(myURL as URL, options: [:], completionHandler: nil)
        
        // Display the simple alert since we cannot test the above
        // code on the simulator
        let alertController = UIAlertController(title: "Calling..", message: "\(number)", preferredStyle: .alert)
        
        let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        alertController.addAction(dismissButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //function for e-mail.
    func sendAnEMail()
    {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        let toRecipients = [sentEmail]
        
        mailComposeVC.setToRecipients(toRecipients as? [String])
        mailComposeVC.setSubject("\(sentName)")
        mailComposeVC.setMessageBody("App Name: KC-EDirectory; Author Name: Kartheek Chintalapati; Z-ID: z1788719", isHTML: false)
        
        //present the view controller modally
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeVC, animated: true, completion: nil)
        }
    }
    
    
    
    func changeDate(dateString: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        let date = dateFormatter.date(from: dateString) //according to date format your date string
        //print(date ?? "") //Convert String to Date
        
        dateFormatter.dateFormat = "MMM d, yyyy" //Your New Date format as per requirement change it own
        let newDate = dateFormatter.string(from: date!) //pass Date here
        //print(newDate) //New formatted Date string
        
        return newDate
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
