//
//  MyPatientsListViewController.swift
//  RelaxNow
//
//  Created by Pritrum on 06/03/21.
//

import UIKit

class MyPatientsListViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePicButton: UIButton!
    
    @IBOutlet weak var currentDateButton: UIButton!
    @IBOutlet weak var appointmentCount: UILabel!
    @IBOutlet weak var appointmentLabel: UILabel!
    @IBOutlet weak var departmentPicImageView: UIImageView!
    
    @IBOutlet weak var appointmentListTableView: UITableView!

    private var patients = [PatientData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getListOfPatients()
        setUpUI()
        
    }
    
    // MARK:- Helper Methods 
    private func setUpUI(){
        profilePicButton.layer.cornerRadius = profilePicButton.bounds.height/2
        profilePicButton.layer.masksToBounds = true
        
        departmentPicImageView.layer.cornerRadius = departmentPicImageView.bounds.height/2
        departmentPicImageView.layer.masksToBounds = true

    }
    
    private func setUpData(){
        appointmentCount.text = "\(self.patients.count)"
    }
    
    func registerCell(){
        appointmentListTableView.registerTableCell(identifier: .patientTableViewCell)
    }

    @IBAction func menuAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profilePicAction(_ sender: UIButton) {
        let controller = AddMedicationViewController.instatiate(from: .Appointment)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
 
    private func getListOfPatients(){
        
        
        APIManager.shared().listOfPatientss("1235", "2021-03-08") { [weak self] (patients, alert) in
            if let patients = patients{
                self?.patients.append(contentsOf: patients)
                Helper.dispatchMain {
                    self?.setUpData()
                    self?.appointmentListTableView.reloadData()
                }
            }else{
                debugPrint("Show Alert", alert?.body)
            }
        }
    }

}

extension MyPatientsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.patientTableViewCell.rawValue, for: indexPath) as? PatientTableViewCell
        let patient = self.patients[indexPath.item]
        cell?.configureMyPatientCell(with: patient, atIndexPath: indexPath)

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
