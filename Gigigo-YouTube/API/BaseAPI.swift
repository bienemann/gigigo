//
//  BaseAPI.swift
//  Gigigo-YouTube
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import Foundation
import Alamofire

class BaseAPI: NSObject {

    static let idUser = "channelId=UCE_M8A5yxnLfW0KghEeajjw"
    static let apiKey = "key=AIzaSyBPlVYsLeKqj9u7wjIQFzamljTaFKPVFSE"
    static let playlistsURL =
    "https://www.googleapis.com/youtube/v3/playlists?part=snippet,contentDetails&maxResults=50"
    static let itemURL = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50"
}
