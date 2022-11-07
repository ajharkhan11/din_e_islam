

import Foundation
struct Offset : Codable {
	let imsak : Int?
	let fajr : Int?
	let sunrise : Int?
	let dhuhr : Int?
	let asr : Int?
	let maghrib : Int?
	let sunset : Int?
	let isha : Int?
	let midnight : Int?

	enum CodingKeys: String, CodingKey {

		case imsak = "Imsak"
		case fajr = "Fajr"
		case sunrise = "Sunrise"
		case dhuhr = "Dhuhr"
		case asr = "Asr"
		case maghrib = "Maghrib"
		case sunset = "Sunset"
		case isha = "Isha"
		case midnight = "Midnight"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		imsak = try values.decodeIfPresent(Int.self, forKey: .imsak)
		fajr = try values.decodeIfPresent(Int.self, forKey: .fajr)
		sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
		dhuhr = try values.decodeIfPresent(Int.self, forKey: .dhuhr)
		asr = try values.decodeIfPresent(Int.self, forKey: .asr)
		maghrib = try values.decodeIfPresent(Int.self, forKey: .maghrib)
		sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
		isha = try values.decodeIfPresent(Int.self, forKey: .isha)
		midnight = try values.decodeIfPresent(Int.self, forKey: .midnight)
	}

}
