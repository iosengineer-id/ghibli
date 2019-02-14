//
//  ViewController.swift
//  Ghibli
//
//  Created by rakhmat cahyadi on 12/2/19.
//  Copyright © 2019 rakhmat cahyadi. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var movies = [Movie]()
    fileprivate let apiService = MovieApiService()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apiService.getMovieList()
            .subscribe(onNext: { [weak self] movies in
                self?.updateMoviesAndReloadData(movies: movies)
            }, onError: { [weak self] error in
                self?.displayMessage(error)
            }).disposed(by: disposeBag)
        
        tableView.estimatedRowHeight = 89
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func updateMoviesAndReloadData(movies:[Movie]) {
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func displayMessage(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok bro", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
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

