//
//  AuthService.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/11/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit
import Alamofire

class AuthService {
    
    static let instance = AuthService()
    
    static let API_AUTH_NAME = "<YOUR_HEROKU_API_ADMIN_NAME>"
    static let API_AUTH_PASSWORD = "<YOUR_HEROKU_API_PASSWORD>"
    static let BASE_URL = "https://protected-anchorage-18127.herokuapp.com/api"
    
    
    
    
    
    
    
    let apiKey = "64f0c8b293c13d2b462d07ebab329965"
    let getTokenMethod = "authentication/token/new"
    let baseURLSecureString = "https://api.themoviedb.org/3/"
    var requestToken: String?
    
    func getRequestToken(username: String, password: String, completion: @escaping Callback) {
        
        let urlString = baseURLSecureString + getTokenMethod + "?api_key=" + apiKey
        let header = ["Accept": "application/json"]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                
                let responseDictionary = JSON as! NSDictionary
                if let requestToken = responseDictionary["request_token"] as? String {
                    self.requestToken = requestToken
                    self.loginWithToken(requestToken: self.requestToken!, username: username, password: password)
                    completion(true)
                }
                
            case .failure(let error):
                print("the error:", error)
                completion(false)
                return
            }
        }
    }
    
    let loginMethod = "authentication/token/validate_with_login"
    
    func loginWithToken(requestToken: String, username: String, password: String) {
        
        let parameters = "?api_key=\(apiKey)&request_token=\(requestToken)&username=\(username)&password=\(password)"
        let urlString = baseURLSecureString + loginMethod + parameters
        let header = ["Accept": "application/json"]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                print("JSON: ", JSON)
                let responseDictionary = JSON as! NSDictionary
                
                if (responseDictionary["success"] as? Bool) != nil {
                    self.getSessionID(requestToken: self.requestToken!)
                    
                }
                
            case .failure(let error):
                print("the error:", error)
                return
            }
        }
    }
    
    let getSessionIdMethod = "authentication/session/new"
    var sessionID: String?
    
    func getSessionID(requestToken: String) {
        let parameters = "?api_key=\(apiKey)&request_token=\(requestToken)"
        let urlString = baseURLSecureString + getSessionIdMethod + parameters
        let header = ["Accept": "application/json"]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                print("JSON: ", JSON)
                let responseDictionary = JSON as! NSDictionary
                
                if let sessionID = responseDictionary["session_id"] as? String {
                    self.sessionID = sessionID
                    print("Session ID: \(sessionID)")
                    self.getUserID(sessionID: self.sessionID!)
                }
                
            case .failure(let error):
                print("the error:", error)
                return
            }
        }
    }
    
    let getUserIdMethod = "account"
    var userID: Int?
    
    func getUserID(sessionID: String) {
        let urlString = baseURLSecureString + getUserIdMethod + "?api_key=" + apiKey + "&session_id=" + sessionID
        let header = ["Accept": "application/json"]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                print("JSON: ", JSON)
                let responseDictionary = JSON as! NSDictionary
                
                if let userID = responseDictionary["id"] as? Int {
                    self.userID = userID
                    print("your user id: \(userID)")
                    //                    self.completeLogin()
                }
                
            case .failure(let error):
                print("the error:", error)
                return
            }
        }
    }
    
    //    func completeLogin() {
    //        guard let userId = userID else { return }
    //        let getFavoritesMethod = "account/\(userId)/favorite/movies"
    //        let urlString = baseURLSecureString + getFavoritesMethod + "?api_key=" + apiKey + "&session_id=" + sessionID!
    //        let url = NSURL(string: urlString)!
    //        let request = NSMutableURLRequest(url: url as URL)
    //        request.addValue("application/json", forHTTPHeaderField: "Accept")
    //        let session = URLSession.shared
    //        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
    //            if let error = downloadError {
    ////                dispatch_async(dispatch_get_main_queue()) {
    ////                    self.debugTextLabel.text = "Cannot retrieve information about user \(self.userID)."
    ////                }
    //                print("Could not complete the request \(error)")
    //            } else {
    //                let parsedResult = try! JSONSerialization.JSONObjectWithData(data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
    //                if let results = parsedResult["results"] as? NSArray {
    //                    dispatch_async(dispatch_get_main_queue()) {
    //                        let firstFavorite = results.firstObject as? NSDictionary
    //                        let title = firstFavorite?.valueForKey("title")
    //                        self.debugTextLabel.text = "Title: \(title!)"
    //                    }
    //                } else {
    ////                    dispatch_async(dispatch_get_main_queue()) {
    ////                        self.debugTextLabel.text = "Cannot retrieve information about user \(self.userID)."
    ////                    }
    //                    print("Could not find 'results' in \(parsedResult)")
    //                }
    //            }
    //        }
    //        task.resume()
    //    }
    
    
}
