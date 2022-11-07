
import Foundation
struct Gregorian : Codable {
	let date : String?
	let format : String?
	let day : String?
	let weekday : Weekday?
	let month : Month?
	let year : String?
	let designation : Designation?

	enum CodingKeys: String, CodingKey {

		case date = "date"
		case format = "format"
		case day = "day"
		case weekday = "weekday"
		case month = "month"
		case year = "year"
		case designation = "designation"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		format = try values.decodeIfPresent(String.self, forKey: .format)
		day = try values.decodeIfPresent(String.self, forKey: .day)
		weekday = try values.decodeIfPresent(Weekday.self, forKey: .weekday)
		month = try values.decodeIfPresent(Month.self, forKey: .month)
		year = try values.decodeIfPresent(String.self, forKey: .year)
		designation = try values.decodeIfPresent(Designation.self, forKey: .designation)
	}

}
