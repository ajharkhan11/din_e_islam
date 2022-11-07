//
//  APIService.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 03/10/22.
//

import UIKit

class APIService :  NSObject {
    // https://api.aladhan.com/v1/asmaAlHusna
    var prayerUrl = "https://api.aladhan.com/v1/calendar?latitude=27.881563&longitude=75.155787&method=5&month=11&year=2022"
    
    
    func apiToGetPrayerData(completion : @escaping (Base?, Error?) -> ()){
        DispatchQueue.global().async {
            var baseData : Base?
            var responseError : Error?

            
            let dataTask = URLSession.shared.dataTask(with: URL(string: self.prayerUrl)!, completionHandler: { (data, response, error) in
                defer{
                    completion(baseData, responseError)
                }
                if let error = error {
                    responseError = error
                    print(error.localizedDescription)
                    return;
                }
                let jsonDecoder = JSONDecoder()
                if let data = data {
                    do {
                        baseData = try jsonDecoder.decode(Base.self, from: data)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    func apiToGetHomeData(completionHandler: @escaping ([HomeModel]?, NSException?) -> ()) {
        DispatchQueue.global().async {
            var homeData : [HomeModel]?
            var responseError : NSException?
            
            defer{
                completionHandler(homeData, responseError)
            }
            
            if let fileUrl = Bundle.main.url(forResource: "homeList", withExtension: "json"){
                let data = try? Data.init(contentsOf: fileUrl)

                if let data = data {

                    let jsonDecoder = JSONDecoder()
                    do {
                         homeData = try jsonDecoder.decode([HomeModel].self, from: data)
                    } catch let exception {
                        print(exception)
                    }
                }
            }else{
                responseError = NSException.init(name: .objectNotAvailableException, reason: "No file to read", userInfo: nil)
            }
        }
    }
    
    func apiToGetMoreData(completionHandler: @escaping (MoreBase?, NSException?) -> ()) {
        DispatchQueue.global().async {
            var moreData : MoreBase?
            var responseError : NSException?
            
            defer{
                completionHandler(moreData, responseError)
            }
            
            if let fileUrl = Bundle.main.url(forResource: "More", withExtension: "json"){
                let data = try? Data.init(contentsOf: fileUrl)

                if let data = data {

                    let jsonDecoder = JSONDecoder()
                    do {
                         moreData = try jsonDecoder.decode(MoreBase.self, from: data)
                    } catch let exception {
                        print(exception)
                    }
                }
            }else{
                responseError = NSException.init(name: .objectNotAvailableException, reason: "No file to read", userInfo: nil)
            }
        }
    }
}
