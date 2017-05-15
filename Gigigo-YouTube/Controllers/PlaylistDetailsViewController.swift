//
//  PlaylistDetailsViewController.swift
//  Gigigo-YouTube
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PlaylistDetailsViewController: UITableViewController {

    var videos: [YoutubeVideo?] = []
    var playlistID: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let videosURL = "\(BaseAPI.itemURL)&\(BaseAPI.idUser)&\(BaseAPI.apiKey)&playlistId=\(playlistID)"
        Alamofire.request(videosURL).responseObject { (response: DataResponse<YoutubePlaylist>) in
            guard let playlistVideos = response.result.value?.videos else { return }
            self.videos = playlistVideos
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoDetailsCell",
                                                       for: indexPath) as? PlaylistItemDetailsCell
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
                cell.textLabel?.text = videos[indexPath.row]?.title
                return cell
        }

        cell.item = videos[indexPath.row]
        cell.setup()
        return cell
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168.0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let videoID = videos[indexPath.row]?.videoID
        let videoURL = "http://www.youtube.com/watch?v=\(videoID!)"
        UIApplication.shared.open(URL(string:videoURL)!, options: [:], completionHandler: nil)

    }
}
