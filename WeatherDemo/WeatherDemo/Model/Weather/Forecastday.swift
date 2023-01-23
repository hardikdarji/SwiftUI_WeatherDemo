

import Foundation
struct Forecastday : Codable, Identifiable {
    var id: UUID = UUID()
    var date : String?
	let day : Day?

	enum CodingKeys: String, CodingKey {
		case date = "date"
		case day = "day"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(String.self, forKey: .date)
        if let strDate = date
        {
            date = strDate.toDate(format: "yyyy-MM-dd")?.toString(format: "dd MMM")
        }
		day = try values.decodeIfPresent(Day.self, forKey: .day)
	}

}
