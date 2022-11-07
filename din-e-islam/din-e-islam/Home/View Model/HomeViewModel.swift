//
//  HomeViewModel.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 05/10/22.
//

import UIKit

class HomeViewModel {
    private var apiService : APIService!
    
    var bindHomeViewModelToController : (()->()) = {}
    
    private(set) var homeList : [HomeModel]!{
        didSet{
            self.bindHomeViewModelToController()
        }
    }
    
    init() {
        self.apiService = APIService()
        self.callFunctionToGetHomeData()
    }
    
    func callFunctionToGetHomeData() {
        self.apiService.apiToGetHomeData { homeData, error in
            if homeData != nil{
                self.homeList = homeData
            }
        }
    }
}
