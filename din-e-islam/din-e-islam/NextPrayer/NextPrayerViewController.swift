//
//  NextPrayerViewController.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 04/11/22.
//

import UIKit

class NextPrayerViewController: UIViewController {

    @IBOutlet weak var gregorian_date: UILabel!
    
    @IBOutlet weak var hijri_date: UILabel!
    
    @IBOutlet weak var remaining_time: UILabel!
    
    @IBOutlet weak var prayer_name: UILabel!
    
    @IBOutlet weak var prayer_time: UILabel!
    
    @IBOutlet weak var circular_view: AJGraph!
    
    private var nextPrayerViewModel : NextPrayerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callFunctionToUpdateUI()
    }

    func callFunctionToUpdateUI() {
        self.nextPrayerViewModel = NextPrayerViewModel()
        self.nextPrayerViewModel.bindPrayerViewModelToController = {
            self.updateCurrentDate()
        }
        
        self.nextPrayerViewModel.bindNextPrayerToController = {
            self.updateNextPrayerUI()
        }
        self.nextPrayerViewModel.handleTimer = { timeInterval in
            self.remaining_time.text = timeInterval.hourMinuteSecond
            
            if let prayer = self.nextPrayerViewModel.prayer {
                if let previousPrayerDate = prayer.previous?.date, let nextPrayerDate = prayer.next?.date {
                    let totaldiff = previousPrayerDate.timeIntervalSince(nextPrayerDate)
                    let currentdiff = nextPrayerDate.timeIntervalSince(Date())
    //                circular_view.duration
                }
            }
            
        }
    }
    
    func updateCurrentDate() {
        DispatchQueue.main.async {
            self.gregorian_date.text = Utils.getGregorianDateForPrayerModel(prayerModel: self.nextPrayerViewModel.nextPrayerModel)
            self.hijri_date.text = Utils.getHijriDateForPrayerModel(prayerModel: self.nextPrayerViewModel.nextPrayerModel)
        }
    }
    
    func updateNextPrayerUI() {
        DispatchQueue.main.async {
            self.prayer_name.text = self.nextPrayerViewModel.prayer.next?.name
            self.prayer_time.text = self.nextPrayerViewModel.prayer.next?.time
            self.nextPrayerViewModel.updateRemaingTimer()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
