//
//  PlaylistItemDetailsCell.swift
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

class PlaylistItemDetailsCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var updated: UILabel!
    @IBOutlet weak var channel: UILabel!
    var item: YoutubeVideo?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    func setup() {

        cleanup()
        guard let itemData = item else { return }

        title.text = itemData.title
        updated.text = itemData.publishedAt!.timeAgoSinceNow
        channel.text = itemData.channelTitle
        videoDescription.text = itemData.description

        thumbnail.af_setImage(withURL: URL(string: itemData.thumbnails!.medium!)!,
                              placeholderImage: nil,
                              filter: nil,
                              imageTransition: .crossDissolve(0.5))
    }

    func cleanup() {
        title.text = ""
        updated.text = ""
        channel.text = ""
        videoDescription.text = ""
        thumbnail.image = nil
    }

}
