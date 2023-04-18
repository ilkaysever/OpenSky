//
//  NetworkHelper.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import Foundation

struct Constants {
    static let API_KEY = "c8663b3a5e6e1d41ab253805b21e4d6e"
    static let BASE_URL = "https://opensky-network.org/api/states/all?time=1458564121&icao24=3c6444"
    static let imgBaseURL = "https://image.tmdb.org/t/p/w500"
}

enum ErrorType: String, Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Inlavid Url"
    case unknownError = "An error unknown"
}

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
}
