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
        return get(url: url).map { data -> [Movie]? in
            return try? JSONDecoder().decode([Movie].self, from: data)
        }.flatMap { Observable.from(optional: $0) }
    }
    
    
    //MARK: infrastructure
    
    private func get(url: URL) -> Observable<Data> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                error.map {
                    observer.onError($0)
                }
             
                data.map {
                    observer.onNext($0)
                    observer.onCompleted()
                }
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
            }
    }
    
}
