//
//  AuthService.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/11/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit
import Alamofire
import Locksmith

class AuthService {
    
    static let instance = AuthService()
    
    let API_KEY = ProcessInfo.processInfo.environment["RAPPI_MOVIE_TEST_API_KEY"]
    let BASE_URL = "https://api.themoviedb.org/3/"
    
    let header = ["Accept": "application/json"]
    let GET_TOKEN_METHOD = "authentication/token/new"
    let LOGIN_METHOD = "authentication/token/validate_with_login"
    let GET_SESSION_ID_METHOD = "authentication/session/new"
    let GET_USER_ID_METHOD = "account"
    
    var requestToken: String?
    var sessionID: String?
    var userID: Int?
    
    func getRequestToken(username: String, password: String, completion: @escaping Callback) {
        let urlString = BASE_URL + GET_TOKEN_METHOD + "?api_key=" + API_KEY!
        
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
                print("The error:", error)
                completion(false)
                return
            }
        }
    }
    
    func loginWithToken(requestToken: String, username: String, password: String) {
        let parameters = "?api_key=\(API_KEY!)&request_token=\(requestToken)&username=\(username)&password=\(password)"
        let urlString = BASE_URL + LOGIN_METHOD + parameters
        
        Alamofire.request(urlString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                
                let responseDictionary = JSON as! NSDictionary
                if (responseDictionary["success"] as? Bool) != nil {
                    self.getSessionID(requestToken: self.requestToken!)
                }
                
            case .failure(let error):
                print("The error:", error)
                return
            }
        }
    }
    
    func getSessionID(requestToken: String) {
        let parameters = "?api_key=\(API_KEY!)&request_token=\(requestToken)"
        let urlString = BASE_URL + GET_SESSION_ID_METHOD + parameters
        
        Alamofire.request(urlString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                
                let responseDictionary = JSON as! NSDictionary
                if let sessionID = responseDictionary["session_id"] as? String {
                    self.sessionID = sessionID
                    print("Session ID: \(sessionID)")
                    self.getUserID(sessionID: self.sessionID!)
                }
                
            case .failure(let error):
                print("The error:", error)
                return
            }
        }
    }
    
    func getUserID(sessionID: String) {
        let urlString = BASE_URL + GET_USER_ID_METHOD + "?api_key=" + API_KEY! + "&session_id=" + sessionID
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                let responseDictionary = JSON as! NSDictionary
                print("responseDictionary: \(responseDictionary)")
                
                let username = responseDictionary["username"] as? String ?? ""
                
                if let userID = responseDictionary["id"] as? Int {
                    self.userID = userID
                    print("your user id: \(userID)")
                    
                    self.updateUserLoggedInFlag()
                    
                    self.saveApiTokenInKeychain(tokenString: self.requestToken!, userId: userID, username: username)
                    //                    self.completeLogin()
                }
                
            case .failure(let error):
                print("The error:", error)
                return
            }
        }
    }
    
    func updateUserLoggedInFlag() {
        // Update the NSUserDefaults flag
        let defaults = UserDefaults.standard
        defaults.set("loggedIn", forKey: "userLoggedIn")
        defaults.synchronize()
    }
    
    func saveApiTokenInKeychain(tokenString: String, userId: Int, username: String) {
        // save API AuthToken in Keychain
        do {
            try Locksmith.saveData(data: ["authenticationToken": tokenString], forUserAccount: "AuthToken")
        } catch {
            
        }
        do {
            try Locksmith.saveData(data: ["id": userId], forUserAccount: "currentUserId")
        } catch {
            
        }
        do {
            try Locksmith.saveData(data: ["username": username], forUserAccount: "currentUserName")
        } catch {
            
        }
        
        print("AuthToken recién guardado: \(Locksmith.loadDataForUserAccount(userAccount: "AuthToken")!)")
        print("currentUserId recién guardado: \(Locksmith.loadDataForUserAccount(userAccount: "currentUserId")!)")
        print("currentUserName recién guardado: \(Locksmith.loadDataForUserAccount(userAccount: "currentUserName")!)")
        
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
