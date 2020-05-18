//
//  MarvelResultsViewController.swift
//  Personality Test
//
//  Created by Caleb Keyes on 5/7/20.
//  Copyright © 2020 Caleb Keyes. All rights reserved.
//

import UIKit

class MarvelResultsViewController: UIViewController {
    var responses: [Answer]!
    func calculatePersonalityResult() {
        let responseTypes = responses.map { $0.type }
        var frequencyOfAnswers: [marvelType: Int] = [:]
        for response in responseTypes {
           let newCount: Int
           if let oldCount = frequencyOfAnswers[response] {
                  newCount = oldCount + 1
           } else {
                  newCount = 1
           }
           frequencyOfAnswers[response] = newCount
        }
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by:
        { (pair1, pair2) -> Bool in
                return pair1.value > pair2.value
        })
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        resultAnswerLabel.text = "You are \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }
    
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!
    
    @IBAction func restartTest(_ sender: Any) {
         performSegue(withIdentifier: "unwindToMarvelStart", sender: self)        
    }
}

