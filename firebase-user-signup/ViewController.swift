//
//  ViewController.swift
//  firebase-user-signup
//
//  Created by doug on 3/11/16.
//  Copyright © 2016 Weave. All rights reserved.
//

import UIKit
import Material


class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var signupButton: FabButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
//        let button: FlatButton = FlatButton(frame: CGRectMake(107, 107, 200, 65))
        
        signupButton.setTitle("Sign up", forState: .Normal)
        signupButton.titleLabel!.font = RobotoFont.mediumWithSize(15)
        
    }

    @IBAction func signupButtonWasTapped(sender: AnyObject) {
        
    }
}

