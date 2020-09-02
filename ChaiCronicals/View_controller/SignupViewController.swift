//
//  SignupViewController.swift
//  ChaiCronicals
//
//  Created by Anuj Pandey on 8/5/20.
//  Copyright © 2020 Anuj Pandey. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignupViewController: UIViewController {

    
    var placeHolder = ""
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PwdTextField: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var CancelButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        //transitiontoLoginOptionpage()

        // Do any additional setup after loading the view.
    }
    
    
    func setUpElements()
    {
        ErrorLabel.alpha = 0
        Utilities.styleTextField(FirstNameTextField)
        Utilities.styleTextField(LastNameTextField)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PwdTextField)
        Utilities.styleFilledButton(SignUpButton)
        Utilities.styleFilledButton(CancelButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func validatefields() -> String?{
        //check all fields has string
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PwdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Fill all the fields"
        }
        //Check If Pwd is secure
        
        let cleanedPassword = PwdTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Match Creiteria not Password "
        }
        return nil
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
            
            // Validate the fields
            let error = validatefields()
            
            if error != nil {
                // There's something wrong with the fields, show error message
                showError(error!)
            }
            else {
                
                // Create cleaned versions of the data
                let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = PwdTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Create the user
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                    
                    // Check for errors
                    if err != nil {
                        
                        // There was an error creating the user
                        self.showError("Error creating user")
                    }
                    else {
                        
                        // User was created successfully, now store the first name and last name
                        let db = Firestore.firestore()
                        
                        db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                            
                            if error != nil {
                                // Show error message
                                self.showError("Error saving user data")
                            }
                        }
                        
                        // Transition to the home screen
                        self.transitionToHome()
                    }
                    
                }
                
            }
        }
        
        func showError(_ message:String) {
            
            ErrorLabel.text = message
            ErrorLabel.alpha = 1
        }
    
    func transitiontoLoginOptionpage(){
        let viewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.viewController) as? ViewController
        
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToHome() {
            
            let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
            
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
            
        }
    
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        transitiontoLoginOptionpage()
    }
    
}



    
