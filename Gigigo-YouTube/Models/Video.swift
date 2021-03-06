//
//  Video.swift
//  Gigigo-YouTube
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class YoutubeVideo: Mappable {

    var videoID: String?
    var publishedAt: Date?
    var title: String?
    var description: String?
    var thumbnails: YoutubeThumbnail?
    var channelTitle: String?

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        videoID         <- map["snippet.resourceId.videoId"]
        publishedAt     <- (map["snippet.publishedAt"],
                        DateFormatterTransform(dateFormatter: YoutubeVideo.dateFormatter))
        title           <- map["snippet.title"]
        description     <- map["snippet.description"]
        thumbnails      <- map["snippet.thumbnails"]
        channelTitle    <- map["snippet.channelTitle"]
    }

}
