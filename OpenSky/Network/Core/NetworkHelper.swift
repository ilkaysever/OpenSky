//
//  NetworkHelper.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import Foundation

struct Constants {
    static let BASE_URL = "https://opensky-network.org/api/states/all"
    static let PATH_TIME = "time=1458564121"
    static let PATH_ICAO = "icao24=3c6444"
}

enum ErrorType: String, Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Inlavid Url"
    case unknownError = "An error unknown"
}

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
}
