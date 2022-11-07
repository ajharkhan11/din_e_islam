//
//  PrayerTimeViewModel.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 27/09/22.
//

import UIKit
import Foundation

class PrayerTimeViewModel {

    private var apiService : APIService!
    
    var bindPrayerTimeViewModelToController : (()->()) = {}
    
    var bindSelectedDateToController : (()->()) = {}
    
    var handleTimer : ((TimeInterval)->()) = {_ in }
    
    private(set) var base : Base! {
        didSet{
            self.bindPrayerTimeViewModelToController()
        }
    }
    
    var selectedIndex : Int! {
        didSet{
            self.bindSelectedDateToController()
        }
    }
    
    init() {
        self.apiService = APIService()
        self.callFunctionToGetPrayerData()
    }
    
    func callFunctionToGetPrayerData(){
        self.apiService.apiToGetPrayerData { base, execption in
            if base != nil{
                self.base = base
            }
        }
    }
    
    func getTodayIndex() -> Int? {
        return Utils.getTodayIndex(prayerModel: self.base.prayerModel)
    }
    
    func getGregorianDateForIndex(index:Int) -> String {
        return Utils.getGregorianDateForPrayerModel(prayerModel: self.base.prayerModel?[index])
    }
    
    func getHijriDateForIndex(index:Int) -> String {
        return Utils.getHijriDateForPrayerModel(prayerModel: self.base.prayerModel?[index])
    }
    
    func getNextPrayer(index: Int) -> Prayer? {
        return Utils.getPrayers(index: index, base: self.base).next
    }
    
    func updateRemaingTimer(nextPrayer:Prayer) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if let timeInterval = nextPrayer.date?.timeIntervalSince(Date()){
                self.handleTimer(timeInterval)
            }
        }
    }
}
