//
//  NextPrayerViewModel.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 04/11/22.
//

import Foundation

class NextPrayerViewModel {
    
    private var apiService : APIService!
    
    var bindPrayerViewModelToController : (()->()) = {}
    
    var bindNextPrayerToController : (()->()) = {}
    
    var handleTimer : ((TimeInterval)->()) = {_ in }
    
    private(set) var nextPrayerModel: PrayerModel!{
        didSet{
            self.bindPrayerViewModelToController()
        }
    }
    
    private(set) var prayer : (previous: Prayer?, next: Prayer?)! {
        didSet{
            self.bindNextPrayerToController()
        }
    }
    
    init() {
        self.apiService = APIService()
        self.callFunctionToGetPrayerData()
    }
    
    func callFunctionToGetPrayerData() {
        self.apiService.apiToGetPrayerData { base, error in
            if let base = base{
                if let todayIndex = Utils.getTodayIndex(prayerModel: base.prayerModel){
                    self.nextPrayerModel = base.prayerModel?[todayIndex]
                    let prayers = Utils.getPrayers(index: todayIndex, base: base)
                    self.prayer = prayers
                }
            }
        }
    }
    
    func updateRemaingTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if let timeInterval = self.prayer.next?.date?.timeIntervalSince(Date()){
                self.handleTimer(timeInterval)
            }
        }
    }
}
