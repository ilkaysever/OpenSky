//
//  FlyResponseModel.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//


struct FlyResponseModel: Codable {
    
    var time: Int?
    var states: [State]?
    
}

struct State: Codable {
    
    var icao24: String?
    var callSign: String?
    var originCountry: String?
    var timePosition: Int?
    var lastContact: Int?
    var longitude: Float?
    var latitude: Float?
    var baroAltitude: Float?
    var onGround: Bool?
    var velocity: Float?
    var trueTrack: Float?
    var verticalRate: Float?
    var sensors: [Int]?
    var geoAltitude: Float?
    var squawk: String?
    var spi: Bool?
    var positionSource: Int
    
    init(from decoder: Decoder) throws {
        var values = try decoder.unkeyedContainer()
        self.icao24 = try values.decode(String.self)
        self.callSign = try values.decode(String.self)
        self.originCountry = try values.decode(String.self)
        self.timePosition = try values.decodeIfPresent(Int.self)
        self.lastContact = try values.decode(Int.self)
        self.longitude = try values.decodeIfPresent(Float.self)
        self.latitude = try values.decodeIfPresent(Float.self)
        self.baroAltitude = try values.decodeIfPresent(Float.self)
        self.onGround = try values.decode(Bool.self)
        self.velocity = try values.decodeIfPresent(Float.self)
        self.trueTrack = try values.decodeIfPresent(Float.self)
        self.verticalRate = try values.decodeIfPresent(Float.self)
        self.sensors = try values.decodeIfPresent([Int].self)
        self.geoAltitude = try values.decodeIfPresent(Float.self)
        self.squawk = try values.decodeIfPresent(String.self)
        self.spi = try values.decode(Bool.self)
        self.positionSource = try values.decode(Int.self)
    }
    
}
