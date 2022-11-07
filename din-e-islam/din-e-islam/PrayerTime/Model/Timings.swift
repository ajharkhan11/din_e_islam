

import Foundation
struct Timings : Codable {
	let fajr : String?
	let sunrise : String?
	let dhuhr : String?
	let asr : String?
	let sunset : String?
	let maghrib : String?
	let isha : String?
	let imsak : String?
	let midnight : String?
	let firstthird : String?
	let lastthird : String?
    
    var array : [Prayer] {
        return [Prayer.init(time: Utils.convert24To12(date: self.fajr?.replacingOccurrences(of: " (IST)", with: "")), name: "Fajr", date: nil),
                Prayer.init(time: Utils.convert24To12(date: self.sunrise?.replacingOccurrences(of: " (IST)", with: "")), name: "Sunrise", date: nil),
                Prayer.init(time: Utils.convert24To12(date: self.dhuhr?.replacingOccurrences(of: " (IST)", with: "")), name: "Dhuhr", date: nil),
                Prayer.init(time: Utils.convert24To12(date: self.asr?.replacingOccurrences(of: " (IST)", with: "")), name: "Asr", date: nil),
                Prayer.init(time: Utils.convert24To12(date: self.sunset?.replacingOccurrences(of: " (IST)", with: "")), name: "Sunset", date: nil),
                Prayer.init(time: Utils.convert24To12(date: self.maghrib?.replacingOccurrences(of: " (IST)", with: "")), name: "Maghrib", date: nil),
                Prayer.init(time: Utils.convert24To12(date: self.isha?.replacingOccurrences(of: " (IST)", with: "")), name: "Isha", date: nil)]
    }

	enum CodingKeys: String, CodingKey {

		case fajr = "Fajr"
		case sunrise = "Sunrise"
		case dhuhr = "Dhuhr"
		case asr = "Asr"
		case sunset = "Sunset"
		case maghrib = "Maghrib"
		case isha = "Isha"
		case imsak = "Imsak"
		case midnight = "Midnight"
		case firstthird = "Firstthird"
		case lastthird = "Lastthird"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		fajr = try values.decodeIfPresent(String.self, forKey: .fajr)
		sunrise = try values.decodeIfPresent(String.self, forKey: .sunrise)
		dhuhr = try values.decodeIfPresent(String.self, forKey: .dhuhr)
		asr = try values.decodeIfPresent(String.self, forKey: .asr)
		sunset = try values.decodeIfPresent(String.self, forKey: .sunset)
		maghrib = try values.decodeIfPresent(String.self, forKey: .maghrib)
		isha = try values.decodeIfPresent(String.self, forKey: .isha)
		imsak = try values.decodeIfPresent(String.self, forKey: .imsak)
		midnight = try values.decodeIfPresent(String.self, forKey: .midnight)
		firstthird = try values.decodeIfPresent(String.self, forKey: .firstthird)
		lastthird = try values.decodeIfPresent(String.self, forKey: .lastthird)
	}
}
