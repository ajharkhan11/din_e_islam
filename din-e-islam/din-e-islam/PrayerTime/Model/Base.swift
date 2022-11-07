
import Foundation
struct Base : Codable {
	let code : Int?
	let status : String?
	let prayerModel : [PrayerModel]?

	enum CodingKeys: String, CodingKey {

		case code = "code"
		case status = "status"
		case prayerModel = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(Int.self, forKey: .code)
		status = try values.decodeIfPresent(String.self, forKey: .status)
        prayerModel = try values.decodeIfPresent([PrayerModel].self, forKey: .prayerModel)
	}

}

