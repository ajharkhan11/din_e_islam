//
//  PrayerTimeViewController.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 27/09/22.
//

import UIKit

class PrayerTimeViewController: UIViewController {
    
    @IBOutlet weak var prayerTimeCollectionView: UICollectionView!
    
    @IBOutlet weak var prayerThemeImage: UIImageView!
    
    @IBOutlet weak var selected_date: UILabel!
    
    @IBOutlet weak var hijri_date: UILabel!
    
    @IBOutlet weak var remaining_time: UILabel!
    
    @IBOutlet weak var prayer_name: UILabel!
    
    @IBOutlet weak var prayer_time: UILabel!
    
    @IBOutlet weak var prayer_time_view: UIView!
    
    @IBOutlet weak var circular_view: AJGraph!
     
    private var prayerTimeViewModel : PrayerTimeViewModel!
    
    private var prayerTimeCellIdentifier = "prayer_col_cell"
    
    private var dataSource : GenericCollectionViewDataSource<PrayerTimesCollectionViewCell, PrayerModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prayerTimeCollectionView.register(UINib.init(nibName: "PrayerTimesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: prayerTimeCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callFunctionToUIUpdate()
    }

    func callFunctionToUIUpdate() {
        self.prayerTimeViewModel = PrayerTimeViewModel()
        self.prayerTimeViewModel.bindPrayerTimeViewModelToController = {
            self.updateDataSource()
        }
        self.prayerTimeViewModel.bindSelectedDateToController = {
            self.updateDate()
        }
        
        self.prayerTimeViewModel.handleTimer = {timeInterval in
            self.remaining_time.text = timeInterval.hourMinuteSecond
        }
    }
    
    func updateDataSource() {
        guard let baseModel = self.prayerTimeViewModel.base else {
            return;
        }
        
        self.dataSource = GenericCollectionViewDataSource.init(cellIdentifier: prayerTimeCellIdentifier, items: baseModel.prayerModel, configureCell: { cell, item in
            cell?.loadData(prayerModel: item)
        }, updateIndex: {index in
            self.prayerTimeViewModel.selectedIndex = index
        })
        
        DispatchQueue.main.async {
            self.prayerTimeCollectionView.dataSource = self.dataSource
            self.prayerTimeCollectionView.delegate = self.dataSource
            self.prayerTimeCollectionView.reloadData()
            if let selectedIndex = self.prayerTimeViewModel.getTodayIndex() {
                self.prayerTimeViewModel.selectedIndex = selectedIndex
                if let prayer = self.prayerTimeViewModel.getNextPrayer(index: selectedIndex){
                    self.prayerTimeViewModel.updateRemaingTimer(nextPrayer: prayer)
                    self.prayer_time.text = prayer.time
                    self.prayer_name.text = prayer.name
                    self.remaining_time.text = prayer.date?.timeIntervalSince(Date()).hourMinuteSecond
                    self.prayer_time_view.isHidden = false
                }
            }
        }
    }
    
    func updateDate() {
        if let selectedIndex = self.prayerTimeViewModel.selectedIndex {
            self.prayerTimeCollectionView.scrollToItem(at: IndexPath.init(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
            self.selected_date.text = self.prayerTimeViewModel.getGregorianDateForIndex(index: selectedIndex)
            self.hijri_date.text = self.prayerTimeViewModel.getHijriDateForIndex(index: selectedIndex)
        }
    }
    
    @IBAction func onClickNext(_ sender: UIButton) {
        guard let count = self.prayerTimeViewModel.base.prayerModel?.count else { return }
        if self.prayerTimeViewModel.selectedIndex < count-1 {
            self.prayerTimeViewModel.selectedIndex = self.prayerTimeViewModel.selectedIndex + 1
        }
    }
    
    @IBAction func onClickPrevious(_ sender: UIButton) {
        if self.prayerTimeViewModel.selectedIndex > 0 {
            self.prayerTimeViewModel.selectedIndex = self.prayerTimeViewModel.selectedIndex - 1
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
