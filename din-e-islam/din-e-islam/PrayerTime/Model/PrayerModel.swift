

import Foundation
struct PrayerModel : Codable {
	let timings : Timings?
	let date : PrayerDate?
	let meta : Meta?

	enum CodingKeys: String, CodingKey {

		case timings = "timings"
		case date = "date"
		case meta = "meta"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		timings = try values.decodeIfPresent(Timings.self, forKey: .timings)
		date = try values.decodeIfPresent(PrayerDate.self, forKey: .date)
		meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
	}
}
