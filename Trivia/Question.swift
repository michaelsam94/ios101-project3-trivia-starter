//
//  Question.swift
//  Trivia
//
//  Created by Michael on 23/06/2024.
//

import Foundation


struct Question {
    let question: String
    let category: Category
    let answer1: Option
    let answer2: Option
    let answer3: Option
    let answer4: Option
}

struct Option {
    let option: String
    let isRightOption: Bool
}

enum Category {
    case music
    case art
    case football
    case movies
    
    var name: String {
        switch self {
        case .music:
            return "Music"
        case .art:
            return "Art"
        case .football:
            return "Football"
        case .movies:
            return "Movies"
        }
    }
}
