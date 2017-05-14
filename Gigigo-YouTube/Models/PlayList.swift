//
//  PlayList.swift
//  Gigigo-YouTube
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class YoutubePlaylist: Mappable {

    var totalResults: Int?
    var resultsPerPage: Int?
    var videos: [YoutubeVideo]?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        totalResults    <- map["pageInfo.totalResults"]
        resultsPerPage  <- map["pageInfo.resultsPerPage"]
        videos          <- map["items"]
    }

}
