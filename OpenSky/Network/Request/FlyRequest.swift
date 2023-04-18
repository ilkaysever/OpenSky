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
        //guard let url = URL(string: "\(Constants.BASE_URL)/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        guard let url = URL(string: Constants.BASE_URL) else { return }
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
    
    // func requestMovieDetail(id: Int, completion: @escaping (MovieItem?) -> ()) {
    //     guard let url = URL(string: "\(Constants.BASE_URL)/movie/\(id)?api_key=\(Constants.API_KEY)&language=en-US") else { return }
    //     NetworkManager.shared.request(type: MovieItem.self, url: url, method: .get) { [weak self] response in
    //         guard let self = self else { return }
    //         switch response {
    //         case .success(let data):
    //             completion(data)
    //         case .failure(let error):
    //             self.handleWithError(error)
    //         }
    //     }
    // }
    
    //func requestSeriesSearch(query: String, completion: @escaping (MovieResponseModel?) -> ()) {
    //  guard let url = URL(string: "\(Constants.BASE_URL)/search/tv?api_key=\(Constants.API_KEY)&language=en-US&query=\(query)") else { return }
    // NetworkManager.shared.request(type: MovieResponseModel.self, url: url, method: .get) { [weak self] response in
    //   guard let self = self else { return }
    //  switch response {
    //  case .success(let data):
    //     completion(data)
    // case .failure(let error):
    //    self.handleWithError(error)
    // }
    // }
    // }
    
    private func handleWithError(_ error: Error) {
        debugPrint(error.localizedDescription)
    }
    
}
