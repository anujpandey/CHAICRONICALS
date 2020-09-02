//
//  LogInViewController.swift
//  ChaiCronicals
//
//  Created by Anuj Pandey on 8/5/20.
//  Copyright © 2020 Anuj Pandey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {


    @IBOutlet weak var EmailTextInput: UITextField!
    
    @IBOutlet weak var PwdTextInput: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    
    @IBOutlet weak var CancelButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
        
         setUpElements()
    }
    
    
    func setUpElements()
    {
        ErrorLabel.alpha = 0
        Utilities.styleTextField(EmailTextInput)
        Utilities.styleTextField(PwdTextInput)
        Utilities.styleFilledButton(CancelButton)
        Utilities.styleFilledButton(LoginButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func LoginTapped(_ sender: Any) {
        
        //Validate text Fields
        
        let Email = EmailTextInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let Pwd = PwdTextInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Sign in User

        Auth.auth().signIn(withEmail: Email, password: Pwd) { (result, error) in
            if error != nil{
                self.ErrorLabel.text = error!.localizedDescription
                self.ErrorLabel.alpha  = 1
            }
            else {
            
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
            }
        }
        
        
    }
    
    
    func transitiontoLoginOptionpage(){
        let viewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.viewController) as? ViewController
        
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        transitiontoLoginOptionpage()
        
    }
    
    
}
