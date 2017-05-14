//
//  PlaylistItem.swift
//  Gigigo-YouTube
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class YoutubePlaylistItem: Mappable {

    var publishedAt: Date?
    var title: String?
    var description: String?
    var thumbnails: [YoutubeThumbnail]?
    var playlistID: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        publishedAt <- (map["snippet.publishedAt"],
                        DateFormatterTransform(dateFormatter: YoutubeVideo.dateFormatter))
        title       <- map["snippet.title"]
        description <- map["snippet.description"]
        thumbnails  <- map["snippet.thumbnails"]
        playlistID  <- map["id"]
    }
}
