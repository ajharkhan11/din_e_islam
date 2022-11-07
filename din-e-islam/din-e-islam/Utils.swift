//
//  Utils.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 29/10/22.
//

import Foundation

class Utils {
    static func convert24To12(date:String?) -> String? {
        guard let date = date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date12 = dateFormatter.date(from: date)!
        
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from:date12)
    }
    
    static func getCurrentDate(format:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: Date())
    }
    
    static func convertStringToDate(dateString:String, format:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    
    static func getTodayIndex(prayerModel:[PrayerModel]?) -> Int? {
        
        let filtered = prayerModel?.filter({ prayerModel in
            prayerModel.date?.readable == Utils.getCurrentDate(format: "dd MMM yyyy")
        })
        
        return prayerModel?.firstIndex(where: { prayerModel in
            prayerModel.date?.readable == filtered?.first?.date?.readable
        })
    }
    
    static func getGregorianDateForPrayerModel(prayerModel:PrayerModel?) -> String {
        if let weekday = prayerModel?.date?.gregorian?.weekday?.en, let day = prayerModel?.date?.gregorian?.day, let month = prayerModel?.date?.gregorian?.month?.en, let year = prayerModel?.date?.gregorian?.year {
            return "\(weekday), \(day) \(month) \(year)"
        }
        return ""
    }
    
    static func getHijriDateForPrayerModel(prayerModel:PrayerModel?) -> String {
        if let weekday = prayerModel?.date?.hijri?.weekday?.en, let day = prayerModel?.date?.hijri?.day, let month = prayerModel?.date?.hijri?.month?.en, let year = prayerModel?.date?.hijri?.year {
            return "\(weekday), \(day) \(month) \(year)"
        }
        return ""
    }
    
    static func getPrayers(index: Int, base: Base) -> (previous:Prayer?, next:Prayer?) {
        var nextPrayer : Prayer?
        var previousPrayer : Prayer?
        let prayerModel = base.prayerModel?[index]
        if let prayerTiming = prayerModel?.timings?.array {
            for prayerTime in prayerTiming {
                if let time = prayerTime.time, let date = prayerModel?.date?.readable {
                    let dateString = date + " " + time
                    if let finalDate = Utils.convertStringToDate(dateString: dateString, format: "dd MMM yyyy hh:mm a") {
                        let interval = finalDate.timeIntervalSince(Date())
                        if interval>0 {
                            nextPrayer = prayerTime
                            nextPrayer?.date = finalDate
                            return (previousPrayer, nextPrayer)
                        }else{
                            previousPrayer = nextPrayer
                        }
                    }
                }
            }
        }
        
        return self.getPrayers(index: index+1,base: base)
    }
    
}

extension TimeInterval {
    var hourMinuteSecondMS: String {
        String(format:"%d:%02d:%02d.%03d", hour, minute, second, millisecond)
    }
    var hourMinuteSecond: String {
        String(format:"%02d:%02d:%02d", hour, minute, second, millisecond)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}
