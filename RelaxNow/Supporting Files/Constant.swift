

import Foundation
import UIKit

let NSUSER_DEFAULTS = UserDefaults.standard
let appDelegateObj = UIApplication.shared.delegate as! AppDelegate
public typealias CallBack = ()->()
let SERVER_MESSAGE = "There is a problem with the server, please try again later."
let BASE_URL = "https://app.biyah.pk/app1/"




//struct CellIdentifier {
//    static let appointmentListCell = "AppointmentListCell"
//}

enum CellIdentifier:String{
    case appointmentListCell = "AppointmentListCell"
    case addMedicationTableCell = "AddMedicationTableCell"
    case patientTableViewCell = "PatientTableViewCell"
}
