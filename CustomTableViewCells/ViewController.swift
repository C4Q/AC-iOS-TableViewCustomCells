//
//  ViewController.swift
//  CustomTableViewCells
//
//  Created by C4Q  on 10/31/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movies: [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200.0
    }
    
    func loadData() {
        let allMovies = MovieData.movies
        let sortedMovies = allMovies.sorted{$0.name < $1.name}
        self.movies = sortedMovies
    }
    
    //Two required Data Source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leftAlligned = indexPath.row % 2 == 0
        if leftAlligned {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Movie Cell", for: indexPath)
            if let cell = cell as? MovieTableViewCell {
                let rowToSetUp = indexPath.row
                let movieToSetUp = movies[rowToSetUp]
                cell.titleLabel.text = movieToSetUp.name
                cell.descriptionLabel.text = movieToSetUp.description
                cell.moviePosterImageView.image = UIImage(named: movieToSetUp.posterImageName)
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Right Movie Cell", for: indexPath)
            if let cell = cell as? RightAllignedMovieTableViewCell {
                let movie = movies[indexPath.row]
                cell.titleLabel.text = movie.name
                cell.descriptionLabel.text = movie.description
                cell.moviePosterImageView.image = UIImage(named: movie.posterImageName)
                return cell
            }
        }
        return UITableViewCell()
    }

    @IBAction func sortButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.movies = movies.sorted{$0.genre < $1.genre}
        case 1:
            self.movies = movies.sorted{$0.name < $1.name}
        default:
            break
        }
        tableView.reloadData()
    }

}

