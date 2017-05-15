//
//  UserPlaylistsViewController.swift
//  Gigigo-YouTube
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class UserPlaylistsViewController: UITableViewController {

    var playlists: [YoutubePlaylistItem?] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Playlists de Apple"

        let nib = UINib(nibName: "PlaylistItemCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PlaylistItemCell")

        let playlistURL = "\(BaseAPI.baseURL)&\(BaseAPI.idUser)&\(BaseAPI.apiKey)"
        Alamofire.request(playlistURL).responseObject { (response: DataResponse<PlaylistsList>) in
            print(response)
            guard let playlistData = response.result.value?.playlists else { return }
            self.playlists = playlistData
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistItemCell",
                                                       for: indexPath) as? PlaylistItemCell
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
                cell.textLabel?.text = playlists[indexPath.row]?.title
                return cell
        }

        cell.item = playlists[indexPath.row]
        cell.setup()
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }

}
