

import Foundation
struct Forecastday : Codable, Identifiable {
    var id: UUID = UUID()
    var date : String?
	let day : Day?
    var hour : [Hour]?

	enum CodingKeys: String, CodingKey {
		case date = "date"
		case day = "day"
        case hour = "hour"

	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(String.self, forKey: .date)
        if let strDate = date,
           let newDate = strDate.toDate(format: "yyyy-MM-dd")?.toString(format: "dd MMM")
        {
            date = newDate
        }
		day = try values.decodeIfPresent(Day.self, forKey: .day)
        hour = try values.decodeIfPresent([Hour].self, forKey: .hour)

	}
}
