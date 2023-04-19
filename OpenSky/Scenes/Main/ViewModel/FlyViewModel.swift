//
//  FlyViewModel.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import Foundation

protocol FlyViewModelProtocol: AnyObject {
    func requestAllFly()
    func requestSearchFly(lamin: Double, lomin: Double, lamax: Double, lomax: Double)
}

final class FlyViewModel: FlyViewModelProtocol {
    
    public var didSuccess: ()->() = { }
    public var didFailure: (String)->() = { _ in }
    
    private var flyData: FlyResponseModel?
    private var flyStateData: [State]?
    
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
    
    func requestSearchFly(lamin: Double, lomin: Double, lamax: Double, lomax: Double) {
        FlyRequest.shared.requestLocationFlys(lamin: Float(lamin), lomin: Float(lomin), lamax: Float(lamax), lomax: Float(lomax)) { [weak self] data in
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
    
    func returnFlyState() -> [State]? {
        return flyStateData ?? []
    }
    
    func returnFlyStateCount() -> Int {
        return flyStateData?.count ?? 0
    }
    
}
