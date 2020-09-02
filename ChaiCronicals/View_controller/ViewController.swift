//
//  ViewController.swift
//  ChaiCronicals
//
//  Created by Anuj Pandey on 8/5/20.
//  Copyright © 2020 Anuj Pandey. All rights reserved.
//

import UIKit
import UIKit
import FBSDKLoginKit
import FirebaseAuth
import Firebase
import AVKit
import GoogleSignIn
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {
    //var videoPlayer : AVPlayer?
    //var videoPlayerLayer : AVPlayerLayer?
    
    
    @IBOutlet weak var FBLoginButton: UIButton!
    
    @IBOutlet weak var GoogleLoginButton: UIButton!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var LogInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            setUpElements()
        
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        }
    }
    
    func setUpElements(){

            Utilities.styleFilledButton(SignUpButton)
            Utilities.styleFilledButton(LogInButton)
    }
    
    
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
//SignIn With Facebook
    @IBAction func FacebookButtonTapped(_ sender: Any)
    {
        
        let fbLoginManager = LoginManager()
            fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                if let error = error {
                    print("Failed to login: \(error.localizedDescription)")
                    return
                }
                
                guard let accessToken = AccessToken.current else {
                    print("Failed to get access token")
                    return
                }
         
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                
                // Perform login by calling Firebase APIs
                Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if let error = error {
                        print("Login error: \(error.localizedDescription)")
                        let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(okayAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        return
                    }
                    
                    // Present the main view
                    if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                })
                    

                }
         
            }
        }
        



    
    

