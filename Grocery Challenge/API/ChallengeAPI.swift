//
//  ChallengeAPI.swift
//  Grocery Challenge
//
//  Created by Andrew Crookston on 5/14/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import Foundation

final class ChallengeAPI {
    let service: Service

    init(service: Service = NetworkService()) {
        self.service = service
    }

    func randomQuestionAsync(request: Requests = APIRequests.questions, _ completion: @escaping (Result<Question>) -> Void) {
        allQuestionsAsync(request: request) { result in
            switch result {
            case .success(let questions):
                guard questions.count > 0 else {
                    completion(.error(APIError.noQuestions))
                    return
                }
                let index = Int(arc4random_uniform(UInt32(questions.count)))
                completion(.success(questions[index]))
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    func allQuestionsAsync(request: Requests = APIRequests.questions, _ completion: @escaping (Result<[Question]>) -> Void) {
        service.get(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let questions: Questions = try JSONDecoder().decode(Questions.self, from: data)
                    completion(.success(questions.questions))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

enum APIRequests: String, Requests {
    case questions = "https://gist.github.com/acrookston/e1af7bf2e2607db3d27a0b44ed1843c1/raw/490d746e54e774476652cf8ab65f9c912e54e95f/question.json"

    var url: URL {
        return URL(string: rawValue)!
    }
}

enum APIError: Error {
    case noQuestions
}

// Only used for decoding
private struct Questions: Codable {
    let questions: [Question]
}
