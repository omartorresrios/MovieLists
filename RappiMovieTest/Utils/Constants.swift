//
//  HTTPHelper.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/13/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import Foundation

// Endpoint URL's
let API_KEY = ProcessInfo.processInfo.environment["RAPPI_MOVIE_TEST_API_KEY"]
let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500"
let BASE_URL = "https://api.themoviedb.org/3/"
let GET_POPULAR_MOVIES_URL = "movie/popular"
let GET_TOP_RATED_MOVIES_URL = "movie/top_rated"
let GET_UPCOMING_MOVIES_URL = "movie/upcoming"

// Auth-Token-Session URL's
let GET_TOKEN_METHOD = "authentication/token/new"
let LOGIN_METHOD = "authentication/token/validate_with_login"
let GET_SESSION_ID_METHOD = "authentication/session/new"
let GET_USER_ID_METHOD = "account"

// Entity names
let topRatedMovie = "TopRatedMovie"
let popularMovie = "PopularMovie"
let upcomingMovie = "UpcomingMovie"

// Others
let parameters = "?api_key=\(API_KEY!)&language=en-US&page=1"
let header = ["Accept": "application/json"]
