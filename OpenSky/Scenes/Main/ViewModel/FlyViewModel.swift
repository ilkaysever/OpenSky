//
//  FlyViewModel.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import Foundation

protocol FlyViewModelProtocol: AnyObject {
    func requestAllFly()
}

final class FlyViewModel: FlyViewModelProtocol {
    
    public var didSuccess: ()->() = { }
    public var didFailure: (String)->() = { _ in }
    
    var flyData: FlyResponseModel?
    var flyStateData: [[State]]?
    
    func requestAllFly() {
        FlyRequest.shared.requestAllFlys { [weak self] data in
            guard let self = self else { return }
            if let data = data, let results = data.states {
                self.flyData = data
                self.flyStateData = results
                self.didSuccess()
            } else {
                self.didFailure(ErrorType.invalidData.rawValue)
            }
        }
    }
    
}
