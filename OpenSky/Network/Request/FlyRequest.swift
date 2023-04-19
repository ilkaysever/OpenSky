//
//  FlyRequest.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import Foundation

class FlyRequest {
    
    static let shared = FlyRequest()
    
    func requestAllFlys(completion: @escaping (FlyResponseModel?) -> ()) {
        guard let url = URL(string: Constants.BASE_URL) else { return }
        debugPrint(url)
        NetworkManager.shared.request(type: FlyResponseModel.self, url: url, method: .get) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                completion(data)
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    func requestStateFlys(completion: @escaping (FlyResponseModel?) -> ()) {
        guard let url = URL(string: "\(Constants.BASE_URL)?\(Constants.PATH_TIME)&\(Constants.PATH_ICAO)") else { return }
        debugPrint(url)
        NetworkManager.shared.request(type: FlyResponseModel.self, url: url, method: .get) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                completion(data)
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    func requestLocationFlys(lamin: Float, lomin: Float, lamax: Float, lomax: Float, completion: @escaping (FlyResponseModel?) -> ()) {
        guard let url = URL(string: "\(Constants.BASE_URL)?lamin=\(lamin)&lomin=\(lomin)&lamax=\(lamax)&lomax=\(lomax)") else { return }
        debugPrint(url)
        NetworkManager.shared.request(type: FlyResponseModel.self, url: url, method: .get) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                completion(data)
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    private func handleWithError(_ error: Error) {
        debugPrint(error.localizedDescription)
    }
    
}
