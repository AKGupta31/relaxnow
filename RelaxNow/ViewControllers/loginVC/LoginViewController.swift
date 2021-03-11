//
//  ViewController.swift
//  RelaxNow
//
//  Created by Admin on 27/02/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var textFeild_email: UITextField!
    @IBOutlet weak var textFeild_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    // MARK: IBActions
    @IBAction func BtnClicked_ForgotPassword(_ sender: Any){
    }
    
    
    @IBAction func BtnClicked_login(_ sender: Any) {
        
        APIManager.shared().loginUserWith("7827990390", "PasswordValue") { [weak self] (userData, alert) in
            if userData != nil{
                UserData.setCurrent(userData!)
                Helper.dispatchMain {
                    let controller = AppoinmentListViewController.instatiate(from: .Appointment)
                    self?.navigationController?.pushViewController(controller, animated: true)
                }
            }else{
                debugPrint("Show Alert", alert?.body)
            }
        }
    }
    

    @IBAction func BtnClicked_showHidePassword(_ sender: Any) {
    }
}

