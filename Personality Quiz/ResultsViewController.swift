//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by Aluno on 22/05/2018.
//  Copyright © 2018 wpstudart. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var responses: [Answer]!
    var answersChosen: [Answer] = []
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    
    
    func calculatePersonalityResult(){
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map { $0.type }
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {(pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        
        let mostCommonAnswers = frequencyOfAnswers.sorted {$0.1 > $1.1}.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswers.rawValue)"
        resultDefinitionLabel.text = mostCommonAnswers.definition
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
