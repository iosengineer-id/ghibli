//
//  ViewController.swift
//  Ghibli
//
//  Created by rakhmat cahyadi on 12/2/19.
//  Copyright © 2019 rakhmat cahyadi. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var movies = [Movie]()
    fileprivate let apiService = MovieApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apiService.getMovieList { [weak self] movies in
            self?.updateMoviesAndReloadData(movies: movies)
        }
        
        
        tableView.estimatedRowHeight = 89
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func updateMoviesAndReloadData(movies:[Movie]) {
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") as! MovieCell
        
        let movie = movies[indexPath.row]

        cell.setup(movie: movie)

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}

