//
//  UserViewModel.swift
//  國泰IOS應徵者林造文作品
//
//  Created by Jef2un_628 on 2023/6/6.
//

import Foundation


struct GetResponse: Codable {
    let response: [Response]
}

struct Response: Codable {
    let name: String
    let kokoid: String?
    let status: Int?
    let isTop: String?
    let fid: String?
    let updateDate: String?
}


