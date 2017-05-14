//
//  PlaylistsList.swift
//  Gigigo-YouTube
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class PlaylistsList: Mappable {

    var totalResults: Int?
    var resultsPerPage: Int?
    var playlists: [YoutubePlaylistItem]?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        totalResults    <- map["pageInfo.totalResults"]
        resultsPerPage  <- map["pageInfo.resultsPerPage"]
        playlists       <- map["items"]
    }

}
