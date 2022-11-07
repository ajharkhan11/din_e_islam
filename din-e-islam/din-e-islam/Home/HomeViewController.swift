//
//  ViewController.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 26/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    private var dataSource : GenericTableViewDataSource<HomeTableViewCell , HomeModel>!
    
    private var homeViewModel : HomeViewModel!
    
    private let cellIdentifier = "home_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.homeTableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.callFunctionToUIUpdate()
    }

    func callFunctionToUIUpdate() {
        self.homeViewModel = HomeViewModel()
        self.homeViewModel.bindHomeViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.dataSource = GenericTableViewDataSource.init(cellIdentifier: cellIdentifier, items: self.homeViewModel.homeList, configureCell: { cell, item in
            cell.titile.text = item?.title
            cell.subTitle.text = item?.desc
            cell.iconView.image = UIImage.init(named: item?.imageName ?? "ghusal")
        })
        
        DispatchQueue.main.async {
            self.homeTableView.dataSource = self.dataSource
            self.homeTableView.delegate = self.dataSource
            self.homeTableView.reloadData()
        }
    }
}

