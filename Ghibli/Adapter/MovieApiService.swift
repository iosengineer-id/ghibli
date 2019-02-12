//
//  MovieApiService.swift
//  Ghibli
//
//  Created by rakhmat cahyadi on 12/2/19.
//  Copyright © 2019 rakhmat cahyadi. All rights reserved.
//

import Foundation

class MovieApiService {
    
    func getMovieList(completion:@escaping ([Movie])->()) {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            if let movies = try? JSONDecoder().decode([Movie].self, from: data) {
                completion(movies)
            }
        }
        
        task.resume()
    }
}
