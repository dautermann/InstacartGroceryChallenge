//
//  Question.swift
//  Grocery Challenge
//
//  Created by Andrew Crookston on 5/14/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import Foundation

struct Question: Codable {
    let query: String // The prompt/title/question we want to ask
    let answers: [Answer] // List of answers (always 4)
}

struct Answer: Codable {
    let url: URL // A URL pointing to a remote image
    let correct: Bool // Is this the correct answer or not
}
