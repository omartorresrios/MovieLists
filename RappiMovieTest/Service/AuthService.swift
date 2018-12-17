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
                
                let username = responseDictionary["username"] as? String ?? ""
                
                if let userID = responseDictionary["id"] as? Int {
                    self.userID = userID
                    print("your user id: \(userID)")
                    
                    self.updateUserLoggedInFlag()
                    self.saveApiTokenInKeychain(tokenString: self.requestToken!, userId: userID, username: username)
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
            print("can't save data in Keychain")
        }
        do {
            try Locksmith.saveData(data: ["id": userId], forUserAccount: "currentUserId")
        } catch {
            print("can't save data in Keychain")
        }
        do {
            try Locksmith.saveData(data: ["username": username], forUserAccount: "currentUserName")
        } catch {
            print("can't save data in Keychain")
        }
        
        print("AuthToken recién guardado: \(Locksmith.loadDataForUserAccount(userAccount: "AuthToken")!)")
        print("currentUserId recién guardado: \(Locksmith.loadDataForUserAccount(userAccount: "currentUserId")!)")
        print("currentUserName recién guardado: \(Locksmith.loadDataForUserAccount(userAccount: "currentUserName")!)")
        
    }
}
