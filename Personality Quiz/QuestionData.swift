//
//  QuestionData.swift
//  Personality Quiz
//
//  Created by Aluno on 22/05/2018.
//  Copyright © 2018 wpstudart. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐈", rabbit = "🐰", turtle = "🐢"
    var definition: String {
        switch self {
        case .dog:
            return "Roof Roof"
        case .cat:
            return "Meow"
        case .rabbit:
            return "Bunny Hop!"
        case .turtle:
            return "..."
        }
    }
}

