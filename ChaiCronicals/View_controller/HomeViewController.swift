//
//  HomeViewController.swift
//  ChaiCronicals
//
//  Created by Anuj Pandey on 8/5/20.
//  Copyright © 2020 Anuj Pandey. All rights reserved.
//

import UIKit
import AVKit
import UIKit
import FBSDKLoginKit
import FirebaseAuth
import Firebase
import AVKit
import GoogleSignIn

class HomeViewController: UIViewController {
    
    var videoPlayer : AVPlayer?
    var videoPlayerLayer : AVPlayerLayer?

    var date = Date()
    
    @IBOutlet weak var Logout: UIButton!
    
    
    @IBOutlet weak var DatePicketObj: UIDatePicker!
    
    @IBOutlet weak var ChaiTimeLabel: UILabel!
    
    @IBOutlet weak var SendNotificationObj: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateChaiTime("Koi Chai Pilane wala nahi hai")

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
    }
        

    func setupVideo(){
        
        //get the path of resource in bundle
        let bundlepath = Bundle.main.path(forResource: "ChaiVideo", ofType: "mp4")
        
        guard bundlepath != nil else{
            return
        }
        //create an URL from it
        let url = URL(fileURLWithPath: bundlepath!)
        
        //cretae player Item
        let item = AVPlayerItem(url: url)
        //create Player
        videoPlayer = AVPlayer(playerItem: item)
        //create layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
        //Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width:self.view.frame.size.width*4, height: self.view.frame.size.height)
            
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        //Add to view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
        
    }
    
    
    func validatefields() -> String?{
        //check all fields has string
        if DatePicketObj != nil{
            //Send Notification and update Label
        }
            return "Fill all the fields"
        }

    
    func UpdateChaiTime(_ message:String) {
        ChaiTimeLabel.text = ""
        ChaiTimeLabel.text = message
        ChaiTimeLabel.alpha = 1
    }
    
    
    
    @IBAction func DateTimeSelected(_ sender: Any) {
        
        if DatePicketObj == nil{
            UpdateChaiTime("Koi Chai Pilane wala nahi hai")
        }
        else {
            
            let comp = DatePicketObj.calendar.dateComponents([.hour, .minute], from: DatePicketObj.date)
            print(comp.hour!)
            print(comp.minute!)
            UpdateChaiTime("Chai at \(comp.hour!) : \(comp.minute!)?")
            
    }
    
}
    func transitiontoLoginOptionpage(){
        let viewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.viewController) as? ViewController
        
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func SendNotificationTapped(_ sender: Any) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
        AnalyticsParameterItemID: "id-\(title!)",
        AnalyticsParameterItemName: title!,
        AnalyticsParameterContentType: "Test"
        
        ])
    }
    
    
    @IBAction func LogutTapped(_ sender: Any) {
        print("Anuj")
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        transitiontoLoginOptionpage()
        }
    //let loginManager = LoginManager()
        //loginManager.logOut()
    }


