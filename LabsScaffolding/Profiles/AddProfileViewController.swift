//
//  AddProfileViewController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class AddProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var avatarURLTextField: UITextField!
    
    var profileController: ProfileController = ProfileController.shared
    var keyboardDismissalTapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpKeyboardDismissalRecognizer()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        avatarURLTextField.delegate = self
    }
    
    private func setUpKeyboardDismissalRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(recognizer)
        keyboardDismissalTapRecognizer = recognizer
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addProfile(_ sender: Any) {
        
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let avatarURLString = avatarURLTextField.text,
            let avatarURL = URL(string: avatarURLString),
            let profile = profileController.createProfile(with: email, name: name, avatarURL: avatarURL) else {
                NSLog("Fields missing information. Present alert to notify user to enter all information.")
                return
        }
        
        profileController.addProfile(profile) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}

extension AddProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            avatarURLTextField.becomeFirstResponder()
        case avatarURLTextField:
            avatarURLTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
