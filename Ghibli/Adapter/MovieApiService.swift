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

    func getMovieList() -> Single<[Movie]> {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
        return get(url: url).map { data -> [Movie]? in
            return try? JSONDecoder().decode([Movie].self, from: data)
        }.flatMap { Observable.from(optional: $0).asSingle() }
    }
    
    
    //MARK: infrastructure
    
    private func get(url: URL) -> Single<Data> {
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                error.map {
                    single(.error($0))
                }
                
                data.map {
                    single(.success($0))
                }
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
}
