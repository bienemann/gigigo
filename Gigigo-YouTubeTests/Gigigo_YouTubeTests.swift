//
//  Gigigo_YouTubeTests.swift
//  Gigigo-YouTubeTests
//
//  Created by Allan Denis Martins on 14/05/17.
//  Copyright © 2017 Aya. All rights reserved.
//

import XCTest
import ObjectMapper
import AlamofireObjectMapper
@testable import Gigigo_YouTube

class Gigigo_YouTubeTests: XCTestCase {
    
    var viewController: UserPlaylistsViewController?
    var navController: UINavigationController?
    var storyBoard: UIStoryboard?
    
    override func setUp() {
        super.setUp()
        
        self.storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.navController = self.storyBoard?.instantiateInitialViewController() as? UINavigationController
        let _ = self.navController?.view
        self.viewController = self.navController?.topViewController as? UserPlaylistsViewController
        let _ = self.viewController!.view
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewControllerExistence() {
        XCTAssertNotNil(self.viewController, "view controller no instantiated")
        XCTAssertNotNil(self.viewController?.tableView, "tableview not instntiated")
    }
    
    func testTableView() {
        
        guard let playlists = self.mockPlaylists() else {
            XCTAssertTrue(false, "unable to mock playlists")
            return
        }
        
        guard let playlistData = playlists.playlists else {
            XCTAssertTrue(false, "unable to mock playlists")
            return
        }
        
        self.viewController?.playlists = playlistData
        self.viewController?.tableView.reloadData()
        
        XCTAssert((self.viewController?.tableView.numberOfRows(inSection: 0))! == 10)
        
        
    }
    
    func testPlaylistItemCell() {
        
        guard let playlists = self.mockPlaylists() else { return }
        guard let playlistData = playlists.playlists else { return }
        self.viewController?.playlists = playlistData
        self.viewController?.tableView.reloadData()
        let cell = self.viewController?.tableView.cellForRow(at: IndexPath(row: 2, section: 0))
            as! PlaylistItemCell
        
        XCTAssertTrue(cell.title.text == "Discover More", "cell didn't load correctly")
        
        self.viewController?.performSegue(withIdentifier: "playlistDetails", sender: cell)
        let details = self.storyBoard?.instantiateViewController(withIdentifier: "PlaylistDetailsViewController")
            as? PlaylistDetailsViewController
        let _ = details!.view
        
        XCTAssertNotNil(details, "view controller no instantiated")
        XCTAssertNotNil(details?.tableView, "tableview not instntiated")

    }
    
    func testPlaylistDetails() {
        
        guard let playlists = self.mockPlaylists() else { return }
        guard let playlistData = playlists.playlists else { return }
        self.viewController?.playlists = playlistData
        self.viewController?.tableView.reloadData()
        let cell = self.viewController?.tableView.cellForRow(at: IndexPath(row: 2, section: 0))
            as! PlaylistItemCell
        
        let details = self.storyBoard?.instantiateViewController(withIdentifier: "PlaylistDetailsViewController")
            as? PlaylistDetailsViewController
        let _ = details!.view
        
        let row = self.viewController?.tableView.indexPath(for: cell)!.row
        let item = self.viewController?.playlists[row!]
        details?.title = item?.title
        details?.playlistID = (item?.playlistID)!
        
        guard let playlistVideos = self.mockPlaylistDetails()?.videos else { return }
        details?.videos = playlistVideos
        details?.tableView.reloadData()
        
        let detailsCell = details?.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
            as! PlaylistItemDetailsCell
        
        XCTAssertTrue(detailsCell.title.text == "How to shoot stills while filming on iPhone 7 — Apple",
                      "cell didn't load correctly")
    }
    
    func mockPlaylists() -> PlaylistsList? {
        
        let path = Bundle(for: Gigigo_YouTubeTests.self)
            .path(forResource: "playlists", ofType: "json")
        let JSONData: Data?
        
        do {
            
            JSONData = try Data(contentsOf: URL(fileURLWithPath: path!))
            let jsonResult: NSDictionary = try (JSONSerialization
                .jsonObject(with: JSONData!, options: .mutableContainers) as? NSDictionary)!
            
            let playlists = PlaylistsList(JSON: jsonResult as! [String : Any])
            return playlists ?? nil
            
        } catch { return nil }
        
    }
    
    func mockPlaylistDetails() -> YoutubePlaylist? {
    
        let path = Bundle(for: Gigigo_YouTubeTests.self)
            .path(forResource: "playlist", ofType: "json")
        let JSONData: Data?
        
        do {
            
            JSONData = try Data(contentsOf: URL(fileURLWithPath: path!))
            let jsonResult: NSDictionary = try (JSONSerialization
                .jsonObject(with: JSONData!, options: .mutableContainers) as? NSDictionary)!
            
            let playlists = YoutubePlaylist(JSON: jsonResult as! [String : Any])
            return playlists ?? nil
            
        } catch { return nil }
        
    }
    
}
