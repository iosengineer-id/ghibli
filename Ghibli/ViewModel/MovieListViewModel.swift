//
//  MovieListViewModel.swift
//  Ghibli
//
//  Created by rakhmat cahyadi on 14/2/19.
//  Copyright © 2019 rakhmat cahyadi. All rights reserved.
//

import Foundation
import RxSwift

class MovieListViewModel {
    private let apiService: MovieApiService
    private let disposeBag = DisposeBag()
    
    var movies = Variable<[Movie]>([Movie]())
    var errorMessage = Variable<String>("")
    
    init(apiService: MovieApiService) {
        self.apiService = apiService
    }
    
    func viewLoad() {
        apiService.getMovieList()
            .subscribe(onSuccess: { [weak self] movies in
                self?.movies.value = movies
            }, onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            }).disposed(by: disposeBag)
    }
    
}
