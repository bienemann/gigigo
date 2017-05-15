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

        let playlistURL = "\(BaseAPI.playlistsURL)&\(BaseAPI.idUser)&\(BaseAPI.apiKey)"
        Alamofire.request(playlistURL).responseObject { (response: DataResponse<PlaylistsList>) in
            print(response)
            guard let playlistData = response.result.value?.playlists else { return }
            self.playlists = playlistData
            self.tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if  segue.identifier == "playlistDetails" &&
        segue.destination is PlaylistDetailsViewController {

            guard let cell = sender as? PlaylistItemCell else { return }
            guard let destination = segue.destination as? PlaylistDetailsViewController else { return }
            let row = self.tableView.indexPath(for: cell)!.row
            let item = self.playlists[row]
            destination.title = item?.title
            destination.playlistID = (item?.playlistID)!

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
        return 228.0
    }

}
