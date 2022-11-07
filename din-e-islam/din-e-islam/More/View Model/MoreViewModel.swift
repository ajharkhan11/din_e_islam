//
//  MoreViewModel.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 21/10/22.
//

import UIKit

class MoreViewModel {
    var apiService : APIService!
    
    var bindMoreViewModelToController : (()->()) = {}
    
    private(set) var moreModel : MoreBase!{
        didSet{
            self.bindMoreViewModelToController()
        }
    }
    
    init(){
        self.apiService = APIService()
        self.callFunctionToGetMoreData()
    }
    
    func callFunctionToGetMoreData() {
        self.apiService.apiToGetMoreData { moreBase, exception in
            if moreBase != nil{
                self.moreModel = moreBase
            }
        }
    }
}
