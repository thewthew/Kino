//
//  KinoAPI.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol KinoAPIInjected { }
extension KinoAPIInjected {
    var kinoAPI: KinoAPI { return KinoAPI.shared }
}

class KinoAPI {
    public static let shared = KinoAPI()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let jsonDecoder = JSONDecoder()
    private let apiKey = "5473ad565413781b8af8e756e42d37de"

    enum Endpoint: String, CaseIterable {
        case movieExample   = "/movie/550"
        case discoverMovies = "/discover/movie"
        case movieList      = "/genre/movie/list"
    }

    private func fetchResources<T: Decodable>(url: URL,
                                              query: [URLQueryItem]? = nil,
                                              completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let otherQueryItems = query {
            queryItems.append(contentsOf: otherQueryItems)
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        let urlRequest = URLRequest(url: url)
        urlSession.dataTask(with: urlRequest) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(.apiError))
            }
         }.resume()
    }

    public func getPopularMovies(result: @escaping (Result<MoviesInfo, APIServiceError>) -> Void) {
        let discoverMovieURL = baseURL.appendingPathComponent(Endpoint.discoverMovies.rawValue)
        let queryItems = [URLQueryItem(name: "sort_by", value: "popularity.desc")]
        fetchResources(url: discoverMovieURL, query: queryItems, completion: result)
    }

    public func getTrendingMovies(result: @escaping (Result<MoviesInfo, APIServiceError>) -> Void) {
        let discoverMovieURL = baseURL.appendingPathComponent(Endpoint.discoverMovies.rawValue)
        let queryItems = [URLQueryItem(name: "sort_by", value: "trending.desc")]
        fetchResources(url: discoverMovieURL, query: queryItems, completion: result)
    }

    public func getMovieListCategory(result: @escaping (Result<MoviesCategory, APIServiceError>) -> Void) {
        let movieListURL = baseURL.appendingPathComponent(Endpoint.movieList.rawValue)
        fetchResources(url: movieListURL, completion: result)
    }
}
