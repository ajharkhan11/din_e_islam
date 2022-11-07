

import Foundation
struct PrayerDate : Codable {
	let readable : String?
	let timestamp : String?
	let gregorian : Gregorian?
	let hijri : Hijri?

	enum CodingKeys: String, CodingKey {

		case readable = "readable"
		case timestamp = "timestamp"
		case gregorian = "gregorian"
		case hijri = "hijri"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		readable = try values.decodeIfPresent(String.self, forKey: .readable)
		timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
		gregorian = try values.decodeIfPresent(Gregorian.self, forKey: .gregorian)
		hijri = try values.decodeIfPresent(Hijri.self, forKey: .hijri)
	}

}
