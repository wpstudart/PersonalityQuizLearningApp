//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Aluno on 22/05/2018.
//  Copyright © 2018 wpstudart. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var Switch1: UISwitch!
    @IBOutlet weak var Label1: UILabel!
    
    @IBOutlet weak var Switch2: UISwitch!
    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Switch3: UISwitch!
    @IBOutlet weak var Label3: UILabel!
    
    @IBOutlet weak var Switch4: UISwitch!
    @IBOutlet weak var Label4: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderLabel1: UILabel!
    @IBOutlet weak var sliderLabel2: UILabel!
    
    @IBOutlet weak var submitAnswer: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender{
        case button1:
            answersChosen.append(currentAnswers[0])
        case button2:
            answersChosen.append(currentAnswers[1])
        case button3:
            answersChosen.append(currentAnswers[2])
        case button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        
        if Switch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if Switch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if Switch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if Switch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
        
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(slider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type:.single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
            ]), Question(text: "Which activities do you enjoy?",
                         type: .multiple,
                         answers: [
                            Answer(text: "Swimming", type: .turtle),
                            Answer(text: "Sleeping", type: .cat),
                            Answer(text: "Cuddling", type: .rabbit),
                            Answer(text: "Eating", type: .dog)
                ]),
                Question(text: "How much do you enjoy car rides?",
                         type: .ranged,
                         answers: [
                            Answer(text: "I dislike them", type: .cat),
                            Answer(text: "I get a little nervous",
                                   type: .rabbit),
                            Answer(text: "I barely notice them",
                                   type: .turtle),
                            Answer(text: "I love them", type: .dog)
                    ])
    ]
    
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    func updateSingleStack(using answers:[Answer]) {
        singleStackView.isHidden = false
        button1.setTitle(answers[0].text, for: .normal)
        button2.setTitle(answers[1].text, for: .normal)
        button3.setTitle(answers[2].text, for: .normal)
        button4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers:[Answer]){
        multipleStackView.isHidden = false
        Switch1.isOn = false
        Switch2.isOn = false
        Switch3.isOn = false
        Switch4.isOn = false
        Label1.text = answers[0].text
        Label2.text = answers[1].text
        Label3.text = answers[2].text
        Label4.text = answers[3].text
    }
    
    func updateRangedStack(using answers:[Answer]){
        rangedStackView.isHidden = false
        slider.setValue(0.5, animated: false)
        sliderLabel1.text = answers.first?.text
        sliderLabel2.text = answers.last?.text
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        progressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
        
        
        
        
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
