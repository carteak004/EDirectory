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
    
    //MARK: - Outlets
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellButtonLabel: UIButton!
    @IBOutlet weak var phoneButtonLabel: UIButton!
    @IBOutlet weak var emailButtonLabel: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var birthdayButtonLabel: UIButton!
    @IBOutlet weak var genderLabel: UILabel!
    
    //MARK: - Actions
    @IBAction func largeImageViewButton(_ sender: UIButton) {
    }
    
    @IBAction func callButton(_ sender: UIButton) {
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
    
    let mainView = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Loading Labels and Images
        thumbnailView.image = mainView.loadImage(imageUrl: sentThumbnail)
        nameLabel.text = sentName
        cellButtonLabel.setTitle(sentCell, for: .normal)
        phoneButtonLabel.setTitle(sentPhone, for: .normal)
        emailButtonLabel.setTitle(sentEmail, for: .normal)
        addressLabel.text = sentAddress
        birthdayButtonLabel.setTitle(sentDob, for: .normal)
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
