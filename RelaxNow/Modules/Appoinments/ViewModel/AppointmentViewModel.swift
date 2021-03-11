//
//  AppointmentViewModel.swift
//  RelaxNow
//
//  Created by Pritrum on 11/03/21.
//

class AppointmentViewModel: NSObject{
    
    private var doctorId: String?
    
    private var appointmentsList: [PatientData]?
    
    func setAppointmentList(appointments: [PatientData]){
        self.appointmentsList = appointments
    }
    
    var numberOfItems: Int{
        return appointmentsList?.count ?? 0
    }
    
    func appointment(atIndex index: Int) -> PatientData?{
        if appointmentsList?.count ?? 0 > index{
            return appointmentsList?[index] ?? nil
        }
        return nil
    }
    
    override init() {
        super.init()
    }
    
}
