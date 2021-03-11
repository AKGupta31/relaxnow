//
//  AppoinmentListViewController.swift
//  RelaxNow
//
//  Created by Pritrum on 03/03/21.
//

import UIKit

class AppoinmentListViewController: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePicButton: UIButton!
    
    
    @IBOutlet weak var currentDateButton: UIButton!
    @IBOutlet weak var appointmentCount: UILabel!
    @IBOutlet weak var appointmentLabel: UILabel!
    @IBOutlet weak var departmentPicImageView: UIImageView!
    
    
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    
    @IBOutlet weak var appointmentListTableView: UITableView!
    
    var appointmentVM = AppointmentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        self.getListOfAppointments()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUpUI(){
        profilePicButton.layer.cornerRadius = profilePicButton.bounds.height/2
        profilePicButton.layer.masksToBounds = true
        
        departmentPicImageView.layer.cornerRadius = departmentPicImageView.bounds.height/2
        departmentPicImageView.layer.masksToBounds = true

        upcomingAndTodayAppoinmentAction(upcomingButton)
    }
    
    private func setUpData(){
        appointmentCount.text = "\(appointmentVM.numberOfItems)"
    }
    //MARK:- Helper Methods
    func registerCell(){
        appointmentListTableView.registerTableCell(identifier: .patientTableViewCell)
    }
    
//MARK:- UIAction Buttons
    
    @IBAction func menuAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profilePicAction(_ sender: UIButton) {
        let controller = MyPatientsListViewController.instatiate(from: .Appointment)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func upcomingAndTodayAppoinmentAction(_ sender: UIButton) {
        switch sender.tag {
        case 1: // Upcoming
            upcomingButton.backgroundColor = .lightGreen
            todayButton.backgroundColor = .clear
            todayButton.layer.borderWidth = 1
            todayButton.layer.borderColor = UIColor.lightGreen.cgColor
            todayButton.setTitleColor(.lightGreen, for: .normal)
            upcomingButton.setTitleColor(.white, for: .normal)

        default: //Today
            todayButton.backgroundColor = .lightGreen
            upcomingButton.backgroundColor = .clear
            upcomingButton.layer.borderWidth = 1
            upcomingButton.layer.borderColor = UIColor.lightGreen.cgColor
            todayButton.setTitleColor(.white, for: .normal)
            upcomingButton.setTitleColor(.lightGreen, for: .normal)


            break
        }
    }
    
    private func getListOfAppointments(){
        APIManager.shared().listOfAppointments("1235", "2021-03-08") { [weak self] (patients, alert) in
            if let appointments = patients{
                self?.appointmentVM.setAppointmentList(appointments: appointments)
                Helper.dispatchMain {
                    self?.setUpData()
                    self?.appointmentListTableView.reloadData()
                }
            }else{
                debugPrint("Show Alert", alert?.body)
            }
        }
    }
//
//    APIManager.shared().loginUserWith("7827990390", "PasswordValue") { [weak self] (userData, alert) in
//        if userData != nil{
//            UserData.setCurrent(userData!)
//            Helper.dispatchMain {
//                let controller = AppoinmentListViewController.instatiate(from: .Appointment)
//                self?.navigationController?.pushViewController(controller, animated: true)
//            }
//        }else{
//            debugPrint("Show Alert", alert?.body)
//        }
//    }

    
}


extension AppoinmentListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentVM.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.patientTableViewCell.rawValue, for: indexPath) as? PatientTableViewCell
        if let appointment = appointmentVM.appointment(atIndex: indexPath.item){
            cell?.configureMyPatientCell(with: appointment, atIndexPath: indexPath)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}
/*func listOfAppointments(_ doctorId: String,_ date: String, complition: @escaping (_ patients: [PatientData]?, _ message: AlertMessage?)->()){
 let parameter:Parameters = ["query":"\(EndpointItem.doctorAppointments.path)('\(doctorId)','\(date)')",
                             "params":""]
 self.callMethod(type: .loginByMobile, params: parameter) { (appointment: PatientBaseData?, alert) in
     complition(appointment?.patients,alert)
 }
}
*/
