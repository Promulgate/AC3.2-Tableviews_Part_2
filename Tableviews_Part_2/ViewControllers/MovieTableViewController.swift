//
//  MovieTableViewController.swift
//  Tableviews_Part_2//
//  Created by Jason Gresh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    enum Century: Int { case twentieth, twentyFirst }
    enum Genre: Int {
        case animation
        case action
        case drama
    }
    var i = 2
    
    
    internal var movieData: [Movie]?
    
    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier = ["MovieTableViewCell1", "MovieTableViewCell2", "MovieTableViewCell3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        // 1. need to update our table for self-sizing cells
        
        // converting from array of dictionaries
        // to an array of Movie structs
        var movieContainer: [Movie] = []
        for rawMovie in rawMovieData {
            movieContainer.append(Movie(from: rawMovie))
        }
        movieData = movieContainer
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1. update our nav controller's tints and font
        if let navigationController: UINavigationController = self.navigationController {
            navigationController.navigationBar.tintColor = .reelGoodGray
            navigationController.navigationBar.barTintColor = .reelGoodGreen
            navigationController.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.reelGoodGray,
                NSFontAttributeName: UIFont.systemFont(ofSize: 24)
            ]
        }
        
        /**
         *2. add a new bar button
         * Below is programmatic method
         * Done via storyboard
         */
        //        let menuBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "reel"),
        //                                                             style: .plain,
        //                                                             target: nil,
        //                                                             action: nil)
        //
        //        self.navigationItem.setLeftBarButton(menuBarButton, animated: false)
        //
    }
    
    // MARK: - Table view data source
    // Understand delegate & data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let genre = Genre(rawValue: section),
            let data = byGenre(genre) else  {
                return 0
        }
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier[i], for: indexPath)
        guard let genre = Genre(rawValue: indexPath.section),
            let data = byGenre(genre) else {
                
                return cell
        }
        
        // update to use a custom cell subclass
        
        if let movieCell: MovieTableViewCell = cell as? MovieTableViewCell {
            movieCell.movieTitleLabel.text = data[indexPath.row].title
            movieCell.movieSummaryLabel.text = data[indexPath.row].summary
            movieCell.moviePosterImageViewer.image = UIImage(named: data[indexPath.row].poster)
            if i == 1 {
                movieCell.movieYearLabel.text = String(data[indexPath.row].year)
                movieCell.greenTitleBar.text = " "
                movieCell.greenTitleBar.backgroundColor = .reelGoodGreen
                movieCell.bottomBorder.text = " "
                movieCell.bottomBorder.backgroundColor = .reelGoodGray
            }
            if i == 2 {
                movieCell.backgroundContainer.backgroundColor = .reelGoodGreen
                var cast = ""
                for each in data[indexPath.row].cast {
                    cast.append("\(each.firstName) \(each.lastName) \n \n")
                }
                movieCell.starringCastLabel.text = cast
            }
            return movieCell
        }
        
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = String(data[indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let genre = Genre(rawValue: section) else {
            return ""
        }
        
        switch genre {
        case .action:
            return "Action"
        case .animation:
            return "Animation"
        case .drama:
            return "Drama"
        }
    }
    
    // MARK: - Utility
    func by(_ c: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch c {
        case .twentieth:
            filter = { (a) -> Bool in
                a.year < 2001
            }
        case .twentyFirst:
            filter = { (a) -> Bool in
                a.year >= 2001
            }
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted { $0.year < $1.year }
        
        return filtered
    }
    
    func byGenre(_ genre: Genre) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch genre {
        case .action:
            filter = { (a) -> Bool in
                a.genre == "action"
            }
        case .animation:
            filter = { (a) -> Bool in
                a.genre == "animation"
            }
        case .drama:
            filter = { (a) -> Bool in
                a.genre == "drama"
            }
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted { $0.year < $1.year }
        
        return filtered
    }
}
