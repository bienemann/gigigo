//
//  PlaylistItemCell.swift
//  Gigigo-YouTube
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import Foundation
import UIKit
import DateToolsSwift
import Alamofire
import AlamofireImage

class PlaylistItemCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var updated: UILabel!
    var item: YoutubePlaylistItem?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup() {

        cleanup()
        guard let itemData = item else { return }

        title.text = itemData.title
        updated.text = "\(itemData.videoCount!) videos, \(itemData.publishedAt!.timeAgoSinceNow)"

        thumbnail.af_setImage(withURL: thumbnailURL(forData: itemData),
                              placeholderImage: nil,
                              filter: nil,
                              imageTransition: .crossDissolve(0.5))
    }

    func cleanup() {
        title.text = ""
        updated.text = ""
        thumbnail.image = nil
    }

    func thumbnailURL(forData itemData: YoutubePlaylistItem) -> URL {

        let screenWidth = UIScreen.main.bounds.width
        var urlString = ""

        if screenWidth >= 120 && screenWidth < 320 {
            urlString = (itemData.thumbnails?.defaultSize)!
        } else if screenWidth >= 320 && screenWidth < 480 {
            urlString = (itemData.thumbnails?.medium)!
        } else if screenWidth >= 480 && screenWidth < 640 {
            urlString = (itemData.thumbnails?.high)!
        } else if screenWidth >= 640 && screenWidth < 1280 {
            urlString = (itemData.thumbnails?.standard)!
        } else {
            urlString = (itemData.thumbnails?.maxres)!
        }

        return URL(string: urlString)!
    }

}
