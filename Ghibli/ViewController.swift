//
//  ViewController.swift
//  Ghibli
//
//  Created by rakhmat cahyadi on 12/2/19.
//  Copyright © 2019 rakhmat cahyadi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let disposeBag = DisposeBag()
    fileprivate var movieListViewModel: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupMovieListViewModel()
        movieListViewModel.viewLoad()
    }
    
    private func setupMovieListViewModel() {
        movieListViewModel = MovieListViewModel(apiService: MovieApiService())
        
        movieListViewModel.movies
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: "CellIdentifier")) {
                _, movies, cell in
                if let movieCell = cell as? MovieCell {
                    movieCell.setup(movie: movies)
                }
            }
            .disposed(by: disposeBag)
        
        movieListViewModel.errorMessage
            .asDriver().drive(onNext: { [weak self] messsage in
                self?.displayMessage(messsage)
            }).disposed(by: disposeBag)
    }
    
    private func displayMessage(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok bro", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
