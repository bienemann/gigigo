//
//  Thumbnails.swift
//  Gigigo-YouTube
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class YoutubeThumbnail: Mappable {

    var defaultSize: String?
    var medium: String?
    var high: String?
    var standard: String?
    var maxres: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        defaultSize <- map["default.url"]
        standard    <- map["standard.url"]
        medium      <- map["medium.url"]
        high        <- map["high.url"]
        maxres      <- map["maxres.url"]
    }
}
