//
//  PrayerTimesCollectionViewModel.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 24/10/22.
//

import UIKit

class PrayerTimesCollectionViewModel {

    var bindPrayerTimeCollectionView : (()->()) = {}
    
    private(set) var timing : Timings! {
        didSet{
            self.bindPrayerTimeCollectionView()
        }
    }
    
    func updateTimingData(timing:Timings) {
        self.timing = timing
    }
}
