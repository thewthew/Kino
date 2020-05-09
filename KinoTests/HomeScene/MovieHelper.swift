//
//  MovieHelper.swift
//  KinoTests
//
//  Created by Matti on 09/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation
@testable import Kino

extension Movie {

    static var trendingMoviesJSON: String {
        return """
            {
               "page":1,
               "total_results":10000,
               "total_pages":500,
               "results":[
                  {
                     "popularity":6.327,
                     "id":20205,
                     "video":false,
                     "vote_count":15,
                     "vote_average":3.5,
                     "title":"Transmorphers Fall of Man",
                     "release_date":"2009-06-30",
                     "original_language":"en",
                     "original_title":"Transmorphers Fall of Man",
                     "genre_ids":[
                        28,
                        12,
                        878
                     ],
                     "backdrop_path":null,
                     "adult":false,
                     "overview":"In this prequel find the automatons Achilles heel before they",
                     "poster_path":"/auxCVPfbahHAurjoGuBpXB64yfs.jpg"
                  },
                  {
                     "popularity":3.317,
                     "vote_count":26,
                     "video":false,
                     "poster_path":"/qEgG8odMSIUcSMjmqFUe8YUXp9x.jpg",
                     "id":20238,
                     "adult":false,
                     "backdrop_path":"/wwuEWugdrRo0BlzIVVXQpklJ7EF.jpg",
                     "original_language":"en",
                     "original_title":"The Shakiest Gun in the West",
                     "genre_ids":[
                        35,
                        37,
                        10751
                     ],
                     "title":"The Shakiest Gun in the West",
                     "vote_average":6.2,
                     "overview":"Jesse W. Haywood (Don Knotts) graduates from Arnold the Kid",
                     "release_date":"1968-07-10"
                  }
               ]
            }
        """
    }

    static var AdAstarMovieJSON: String {
        return """
        {
           "popularity":458.421,
           "vote_count":3295,
           "video":false,
           "poster_path":"/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
           "id":419704,
           "adult":false,
           "backdrop_path":"/5BwqwxMEjeFtdknRV792Svo0K1v.jpg",
           "original_language":"en",
           "original_title":"Ad Astra",
           "genre_ids":[
              18,
              878
           ],
           "title":"Ad Astra",
           "vote_average":6,
           "overview":"The near future of the unknown.",
           "release_date":"2019-09-17"
        }
        """
    }

    static var popularJSON: String {
        return """
        {
           "page":1,
           "total_results":10000,
           "total_pages":500,
           "results":[
              {
                 "popularity":458.421,
                 "vote_count":3295,
                 "video":false,
                 "poster_path":"/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
                 "id":419704,
                 "adult":false,
                 "backdrop_path":"/5BwqwxMEjeFtdknRV792Svo0K1v.jpg",
                 "original_language":"en",
                 "original_title":"Ad Astra",
                 "genre_ids":[
                    18,
                    878
                 ],
                 "title":"Ad Astra",
                 "vote_average":6,
                 "overview":"The near future of the unknown.",
                 "release_date":"2019-09-17"
              },
              {
                 "popularity":219.819,
                 "vote_count":1627,
                 "video":false,
                 "poster_path":"/wlfDxbGEsW58vGhFljKkcR5IxDj.jpg",
                 "id":545609,
                 "adult":false,
                 "backdrop_path":"/1R6cvRtZgsYCkh8UFuWFN33xBP4.jpg",
                 "original_language":"en",
                 "original_title":"Extraction",
                 "genre_ids":[
                    28,
                    18,
                    53
                 ],
                 "title":"Extraction",
                 "vote_average":7.5,
                 "overview":"Tyler Rake son of a Mumbai crime lord…",
                 "release_date":"2020-04-24"
              },
              {
                 "popularity":80.02,
                 "vote_count":261,
                 "video":false,
                 "poster_path":"/jC1PNXGET1ZZQyrJvdFhPfXdPP1.jpg",
                 "id":597219,
                 "adult":false,
                 "backdrop_path":"/deTb672Jh4HGh48x4MVwHXIytQU.jpg",
                 "original_language":"en",
                 "original_title":"The Half of It",
                 "genre_ids":[
                    35,
                    10749
                 ],
                 "title":"The Half of It",
                 "vote_average":7.4,
                 "overview":"Shy, straight-A student Ellie is hired by same girl.",
                 "release_date":"2020-05-01"
              }
           ]
        }
        """
    }

    static var movieListCategoryJSON: String {
        return """
        {
           "genres":[
              {
                 "id":28,
                 "name":"Actions"
              },
              {
                 "id":27,
                 "name":"Horror"
              },
              {
                 "id":10402,
                 "name":"Music"
              },
              {
                 "id":9648,
                 "name":"Mystery"
              },
              {
                 "id":10749,
                 "name":"Romance"
              },
              {
                 "id":878,
                 "name":"Science Fiction"
              },
              {
                 "id":10770,
                 "name":"TV Movie"
              },
              {
                 "id":53,
                 "name":"Thriller"
              },
              {
                 "id":10752,
                 "name":"War"
              },
              {
                 "id":37,
                 "name":"Western"
              }
           ]
        }
        """
    }
}
