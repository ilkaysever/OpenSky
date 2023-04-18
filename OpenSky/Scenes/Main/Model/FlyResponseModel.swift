//
//  FlyResponseModel.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

struct FlyResponseModel: Codable {

    var time: Int?
    var states: [[State]]?

    enum CodingKeys: String, CodingKey {
        case time
        case states
    }

}

struct State: Codable {

//    var icao24: String?
//    var callsign: String?
//    var origin_country: String?
//    var time_position: Int?
//    var last_contact: Int?
    var longitude: Float?
//    var latitude: Float?
//    var baro_altitude: Float?
//    var on_ground: Bool?
//    var velocity: Float?
//    var true_track: Float?
//    var vertical_rate: Float?
//    var sensors: [Int]?
//    var geo_altitude: Float?
//    var squawk: String?
//    var spi: Bool?
//    var position_source: Int?

    enum CodingKeys: Int, CodingKey {

//       case icao24 = 0
//        case callsign = 1
//        case origin_country = 2
//        case time_position = 3
//        case last_contact = 4
        case longitude = 5
//        case latitude = 6
//        case baro_altitude = 7
//        case on_ground = 8
//        case velocity = 9
//        case true_track = 10
//        case vertical_rate = 11
//        case sensors = 12
//        case geo_altitude = 13
//        case squawk = 14
//        case spi = 15
//        case position_source = 16

    }
}
