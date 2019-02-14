//
//  MovieApiService.swift
//  Ghibli
//
//  Created by rakhmat cahyadi on 12/2/19.
//  Copyright © 2019 rakhmat cahyadi. All rights reserved.
//

import Foundation
import RxSwift

class MovieApiService {

    func getMovieList() -> Observable<[Movie]> {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
        return get(url: url).map { data in
            if let movies = try? JSONDecoder().decode([Movie].self, from: data) {
                return movies
            }
            return []
        }
    }
    
    
    //MARK: infrastructure
    
    private func get(url: URL) -> Observable<Data> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                }
             
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
            }
    }
    
}
