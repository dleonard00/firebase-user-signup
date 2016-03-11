//
//  ViewController.swift
//  firebase-user-signup
//
//  Created by doug on 3/11/16.
//  Copyright © 2016 Weave. All rights reserved.
//

import UIKit
import Material
import Firebase


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var signupButton: FabButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldDelegates()
        setupView()
    }
    
    func setupView(){
        
        usernameTextField.placeholder = "Username"
        usernameTextField.placeholderTextColor = MaterialColor.grey.base
        usernameTextField.font = RobotoFont.regularWithSize(20)
        usernameTextField.textColor = MaterialColor.black
        usernameTextField.borderStyle = .None
        
        usernameTextField.titleLabel = UILabel()
        usernameTextField.titleLabel!.font = RobotoFont.mediumWithSize(12)
        usernameTextField.titleLabelColor = MaterialColor.grey.base
        usernameTextField.titleLabelActiveColor = MaterialColor.blue.accent3
        
        emailTextField.placeholder = "Email"
        emailTextField.placeholderTextColor = MaterialColor.grey.base
        emailTextField.font = RobotoFont.regularWithSize(20)
        emailTextField.textColor = MaterialColor.black
        emailTextField.borderStyle = .None
        
        emailTextField.titleLabel = UILabel()
        emailTextField.titleLabel!.font = RobotoFont.mediumWithSize(12)
        emailTextField.titleLabelColor = MaterialColor.grey.base
        emailTextField.titleLabelActiveColor = MaterialColor.blue.accent3
        
        passwordTextField.placeholder = "Password"
        passwordTextField.placeholderTextColor = MaterialColor.grey.base
        passwordTextField.font = RobotoFont.regularWithSize(20)
        passwordTextField.textColor = MaterialColor.black
        passwordTextField.borderStyle = .None
        
        passwordTextField.titleLabel = UILabel()
        passwordTextField.titleLabel!.font = RobotoFont.mediumWithSize(12)
        passwordTextField.titleLabelColor = MaterialColor.grey.base
        passwordTextField.titleLabelActiveColor = MaterialColor.blue.accent3
        
        let image = UIImage(named: "ic_close_white")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let clearButton: FlatButton = FlatButton()
        clearButton.pulseColor = MaterialColor.grey.base
        clearButton.pulseScale = false
        clearButton.tintColor = MaterialColor.grey.base
        clearButton.setImage(image, forState: .Normal)
        clearButton.setImage(image, forState: .Highlighted)
        
        usernameTextField.clearButton = clearButton
        emailTextField.clearButton = clearButton
        passwordTextField.clearButton = clearButton
        
        signupButton.setTitle("Sign up", forState: .Normal)
        signupButton.titleLabel!.font = RobotoFont.mediumWithSize(15)
    }

    @IBAction func signupButtonWasTapped(sender: AnyObject) {

        
        dismissKeyboard()
        
        let failureClosure: (NSError) -> () = { error in
            self.handleSignUpError(error)
        }
        guard let email = emailTextField.text, username = usernameTextField.text?.lowercaseString, password = passwordTextField.text else {
            alertError("Please fill out the all fields, then try signing up again.")
            return
        }
        if email.isEmpty || password.isEmpty || username.isEmpty {
            alertError("Please fill out the all fields, then try signing up again.")
        }
        
        if username.characters.count > 15 {
            alertError("Usernames must be less than 15 characters.")
            return
        }
        
        //TODO check for conflicts.
        if !isOnlyAlphaNumeric(username){
            print("username must be only alpha numeric characters")
            return
        }
        
        let usernameIndexRef = FirebaseRefManager.myRootRef.childByAppendingPath("username/\(username)")
        usernameIndexRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull { //check that username doesnt already exist.
                let successClosure = {
                    //Do something successful
                }
                
                let failureClosure: (NSError) -> () = { error in
                    self.handleSignUpError(error)
                }
                
                createNewUser(email, username: username, password: password, success: successClosure, failure: failureClosure)
            
            } else {
                self.alertError("Username has already been taken, please pick a new username and try again.")
                return
            }
        })
    }
    
    func handleSignUpError(error: NSError){
        if let errorCode = FAuthenticationError(rawValue: error.code) {
            switch errorCode {
            case .ProviderDisabled:
                print("ProviderDisabled")
                alertError("The requested authentication provider is currently disabled for this app.")
            case .InvalidConfiguration:
                print("InvalidConfiguration")
                alertError("The requested authentication provider is misconfigured, and the request cannot complete.")
            case .InvalidOrigin:
                print("InvalidOrigin")
                alertError("A security error occurred while processing the authentication request. The web origin for the request is not in your list of approved request origins.")
            case .InvalidProvider:
                print("InvalidProvider")
                alertError("The requested authentication provider does not exist. Send mean tweets to @bettrnetHQ")
            case .InvalidEmail:
                print("InvalidEmail")
                alertError("The specified email is not a valid email.")
            case .InvalidPassword:
                print("InvalidPassword")
                alertError("The specified user account password is invalid.")
            case .InvalidToken:
                print("InvalidToken")
                alertError("The specified authentication token is invalid.")
            case .EmailTaken:
                print("EmailTaken")
                alertError("The new user account cannot be created because the specified email address is already in use.")
            case .NetworkError:
                print("NetworkError")
                alertError("An error occurred while attempting to contact the authentication server.")
            case .Unknown:
                print("Unknown")
                alertError("Something went wrong, please try again later.")
            default:
                print("error - default situation")
                alertError("Something went wrong, please try again later.")
            }
        }
    }

    func isOnlyAlphaNumeric(stringInQuestion: String) -> Bool{
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpressionOptions())
        if regex.firstMatchInString(stringInQuestion, options: NSMatchingOptions(), range:NSMakeRange(0, stringInQuestion.characters.count)) != nil {
            print("could not handle special characters")
            alertError("Use only alpha-numeric characters in preferred name.")
            return false
        }
        return true
    }
    
    func alertError(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        switch(textField){
        case self.usernameTextField:
            self.emailTextField.becomeFirstResponder()
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.passwordTextField.resignFirstResponder()
            self.signupButtonWasTapped(textField)
        default:
            self.signupButtonWasTapped(textField)
        }
        return true
    }
    
    func setTextFieldDelegates(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
    }
    
    func dismissKeyboard(){
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.usernameTextField.resignFirstResponder()
    }
}

