//
//  AppointmentViewModel.swift
//  RelaxNow
//
//  Created by Pritrum on 11/03/21.
//

enum AppointmentView:Int {
    case dashboard = 0
    case appointmentScreen
}
enum Tab:Int {
    case upcoming = 0
    case today
}

typealias ReloadDataBlock = (()->())

class AppointmentViewModel: NSObject{
    
    private var doctorId: String?
    
    private var appointmentsList: [PatientData]?
    private var originalDataList:[PatientData]?
    
    private var searchResults: [PatientData]?
    var viewType:AppointmentView = .dashboard
    
    var reloadData:ReloadDataBlock?
    var selectedTab:Tab = .upcoming {
        didSet {
           updateDataToSearchFromArray()
        }
    }
    
    var totalNumberOfItems:Int {
        return originalDataList?.count ?? 0
    }

    func updateDataToSearchFromArray(){
        if self.selectedTab == .today {
            self.appointmentsList = self.originalDataList?.filter({$0.isTodaysAppointment})
        }else {
            self.appointmentsList = self.originalDataList
        }
        self.searchResults = self.appointmentsList
        reloadData?()
    }
    
    func setAppointmentList(appointments: [PatientData]){
        self.originalDataList = appointments
        updateDataToSearchFromArray()
    }
    
    var numberOfItems: Int{
        guard let count = searchResults?.count else {return 0}
        if viewType == .dashboard {
            if count > 5 {return 5};
            return count;
        }
        return searchResults?.count ?? 0
    }
    
    func appointment(atIndex index: Int) -> PatientData?{
        if searchResults?.count ?? 0 > index{
            return searchResults?[index] ?? nil
        }
        return nil
    }
    
    public func resetSearchResult(){
        self.searchResults = self.appointmentsList
    }
    func filterResultWith(text: String){
        let resultArr = self.appointmentsList?.filter({($0.rN_CUSTOMER_FIRST_NAME?.lowercased().contains(text.lowercased()) ?? false)})
        self.searchResults = resultArr
    }
    
    override init() {
        super.init()
    }
    
}
