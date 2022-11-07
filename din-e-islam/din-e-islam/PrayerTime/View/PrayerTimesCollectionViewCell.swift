//
//  PrayerTimesCollectionViewCell.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 23/10/22.
//

import UIKit

class PrayerTimesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var prayerTimeListView: UITableView!
    
    private var prayerTimeCollectionViewModel : PrayerTimesCollectionViewModel!
    
    private var prayerTimeCellIdentifier = "prayer_cell"
    
    private var dataSource : GenericTableViewDataSource<PrayerTableViewCell , Prayer>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.prayerTimeListView.register(UINib.init(nibName: "PrayerTableViewCell", bundle: nil), forCellReuseIdentifier: prayerTimeCellIdentifier)
    }

    func loadData(prayerModel:PrayerModel?) {
        guard let timings = prayerModel?.timings else {
            return
        }
        
        self.prayerTimeCollectionViewModel = PrayerTimesCollectionViewModel()
        
        self.prayerTimeCollectionViewModel.bindPrayerTimeCollectionView = {
            self.updateDataSource()
        }
        self.prayerTimeCollectionViewModel.updateTimingData(timing: timings)
    }
    
    func updateDataSource() {
        let timigArray = self.prayerTimeCollectionViewModel.timing.array
        self.dataSource = GenericTableViewDataSource.init(cellIdentifier: prayerTimeCellIdentifier, items: timigArray, configureCell: { cell, item in
            if let timing = item {
                cell.prayerName.text = timing.name
                cell.prayerTime.text = timing.time
            }
        })
        
        DispatchQueue.main.async {
            self.prayerTimeListView.dataSource = self.dataSource
            self.prayerTimeListView.delegate = self.dataSource
            self.prayerTimeListView.reloadData()
        }
    }
}
