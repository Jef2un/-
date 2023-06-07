//
//  APICaller.swift
//  國泰IOS應徵者林造文作品
//
//  Created by Jef2un_628 on 2023/6/6.
//

import Foundation

struct Constants {
    static let UserUrl = "https://dimanyen.github.io/man.json"
    static let Friends1Url = "https://dimanyen.github.io/friend1.json"
    static let Friends2Url = "https://dimanyen.github.io/friend2.json"
    static let FriendsWithInviteUrl = "https://dimanyen.github.io/friend3.json"
    static let EmptyUrl = "https://dimanyen.github.io/friend4.json"

}

class APICaller {
    static let shared = APICaller()
    
    
    func getUser(completion: @escaping (Result<[Response], Error>) -> Void) {
        guard let url = URL(string: Constants.UserUrl) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GetResponse.self, from: data)
                completion(.success(results.response))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getFriends1(completion: @escaping (Result<[Response], Error>) -> Void) {
        guard let url = URL(string: Constants.Friends1Url) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GetResponse.self, from: data)
                completion(.success(results.response))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    func getFriends2(completion: @escaping (Result<[Response], Error>) -> Void) {
        guard let url = URL(string: Constants.Friends2Url) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GetResponse.self, from: data)
                completion(.success(results.response))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    

}
