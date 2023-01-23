//
//  WeatherModel.swift
//  test_Exercise
//
//  Created by Hardik Darji on 21/01/23.
//

import Foundation
struct Location : Codable {
    let name : String?
    let region : String?
    let country : String?
    var localtime : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case region = "region"
        case country = "country"
        case localtime = "localtime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        localtime = try values.decodeIfPresent(String.self, forKey: .localtime)
        if let dateTime = localtime
        {
            localtime = dateTime.toDate(format: "yyyy-MM-dd HH:mm")?.toString(format: "dd MMM, yyyy")
        }
    }
}
