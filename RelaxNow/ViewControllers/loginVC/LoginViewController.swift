//
//  ViewController.swift
//  RelaxNow
//
//  Created by Admin on 27/02/21.
//

import UIKit
import SwiftSpinner
class LoginViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var textFeild_email: UITextField!
    @IBOutlet weak var textFeild_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textFeild_email.text = "7827990390"
        self.textFeild_password.text = "PasswordValue"
    }
    
    
    // MARK: IBActions
    @IBAction func BtnClicked_ForgotPassword(_ sender: Any){
    }
    
    
    @IBAction func BtnClicked_login(_ sender: Any) {
        guard let mobileNumber = self.textFeild_email.text else{return}
        guard let password = self.textFeild_password.text else {return}
        
        SwiftSpinner.show("Loading...")
        APIManager.shared().loginUserWith(mobileNumber, password) {
            [weak self] (userData, alert) in
            SwiftSpinner.hide()
            if userData != nil{
                UserData.setCurrent(userData!)
                Helper.dispatchMain {
//                    let controller = DashboardViewController.instatiate(from: .Main)
//                    self?.navigationController?.pushViewController(controller, animated: true)
                    
//                    guard let mainViewController = storyboard.instantiateInitialViewController() as? MainViewController else { return }
                    let mainViewController = MainViewController.instatiate(from: .Main)

                    mainViewController.setup(type: .styleSlideBelowShifted)

                    if #available(iOS 13.0, *) {
                        let window = SceneDelegate.shared!.window
                        window?.rootViewController = mainViewController
                        UIView.transition(with: window!, duration: 0.3, options: [.transitionCrossDissolve], animations: nil, completion: nil)

                    } else {
                        // Fallback on earlier versions
                        let window = UIApplication.shared.delegate!.window!!
                        window.rootViewController = mainViewController
                        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve], animations: nil, completion: nil)

                    }//UIApplication.shared.delegate!.window!!
                    

                    
                }
            }else{
                guard let message = alert?.body else{return}
                Utility.sharedInstance.showAlert(Title: "Alert!", message: message, viewcontroller: self!) {
                    
                }
                debugPrint("Show Alert", alert?.body)
            }
        }
    }
    

    @IBAction func BtnClicked_showHidePassword(_ sender: Any) {
    }
}

