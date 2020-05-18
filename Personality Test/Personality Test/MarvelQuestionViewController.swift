//  MarvelQuestionViewController.swift
//  Personality Test
//  Created by Caleb Keyes on 5/7/20.
//  Copyright © 2020 Caleb Keyes. All rights reserved.
import UIKit

var questionIndex = 0

class MarvelQuestionViewController: UIViewController {
    
    //single
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    //multiple
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabel1: UILabel!
    @IBOutlet var multipleLabel2: UILabel!
    @IBOutlet var multipleLabel3: UILabel!
    @IBOutlet var multipleLabel4: UILabel!
    @IBOutlet var multipleSwitch1: UISwitch!
    @IBOutlet var multipleSwitch2: UISwitch!
    @IBOutlet var multipleSwitch3: UISwitch!
    @IBOutlet var multipleSwitch4: UISwitch!
    @IBOutlet var multipleButton: UIButton!
    //slider
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    @IBOutlet var rangedButton: UIButton!
    //title
    @IBOutlet var questionLabel: UILabel!
    //progress
    @IBOutlet var questionProgress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        questionIndex = 0
        disneyQuestionIndex = 0
    }
    var answersChosen: [Answer] = []

    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
            switch sender {
            case singleButton1:
                answersChosen.append(currentAnswers[0])
            case singleButton2:
                answersChosen.append(currentAnswers[1])
            case singleButton3:
                answersChosen.append(currentAnswers[2])
            case singleButton4:
                answersChosen.append(currentAnswers[3])
            default:
                break
            }
         nextQuestion()
    }
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        if multipleSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
            }
            if multipleSwitch2.isOn {
                answersChosen.append(currentAnswers[1])
            }
            if multipleSwitch3.isOn {
                answersChosen.append(currentAnswers[2])
            }
            if multipleSwitch4.isOn {
                answersChosen.append(currentAnswers[3])
            }
            nextQuestion()
        }
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
            let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
            answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        if questionIndex == 7 {
            questionIndex = 0
            disneyQuestionIndex = 0
        }
            let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgress.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
            case .single:
                singleStackView.isHidden = false
            case .multiple:
                multipleStackView.isHidden = false
            case .ranged:
                rangedStackView.isHidden = false
        }
        switch currentQuestion.type {
            case .single:
                updateSingleStack(using: currentAnswers)
            case .multiple:
                updateMultipleStack(using: currentAnswers)
            case .ranged:
                updateRangedStack(using: currentAnswers)
                }
        }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
            multipleSwitch1.isOn = false
            multipleSwitch2.isOn = false
            multipleSwitch3.isOn = false
            multipleSwitch4.isOn = false
                multipleLabel1.text = answers[0].text
                multipleLabel2.text = answers[1].text
                multipleLabel3.text = answers[2].text
                multipleLabel4.text = answers[3].text
    }
    func updateRangedStack(using answers: [Answer]) {
     rangedStackView.isHidden = false
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
            rangedSlider.setValue(0.5, animated: false)
 }
    func nextQuestion() {
        questionIndex += 1
            if questionIndex < questions.count {
                updateUI()
            } else {
                performSegue(withIdentifier: "marvelResults", sender: nil)
            }
    }
    
    var questions: [Question] = [
        Question(text: "New York City is looking for new transportation methods. Which of these would you like to see?",
                 type:.multiple,
                 answers: [
                    Answer(text: "Teleportation", type: .hulk),
                    Answer(text: "Sky train", type: .tony),
                    Answer(text: "Zip lines", type: .spriderman),
                    Answer(text: "Trolley Car", type: .captain)
                          ]),
        Question(text: "An endless army of giant aliens is attacking Earth. How confident are you that you'll make it out of this unscathed?",
                 type: .ranged,
                 answers: [
                       Answer(text: "Very.", type: .hulk),
                       Answer(text: "I've been through worse", type: .captain),
                       Answer(text: "Probably 50/50", type: .tony),
                       Answer(text: "Probably Not", type: .spriderman),
                            ]),
        Question(text: "What is your secret to success?",
                 type:.single,
                 answers: [
                    Answer(text: "Controlling my anger", type: .hulk),
                    Answer(text: "I’m naturally intelligent", type: .tony),
                    Answer(text: "My family", type: .spriderman),
                    Answer(text: "I’m true to my principles", type: .captain)
                          ]),
        Question(text: "Oh no! A group of bank robbers are getting away! What's your main priority?",
                 type: .single,
                 answers: [
                    Answer(text: "Throwing the car", type: .hulk),
                    Answer(text: "Catching the robbers", type: .tony),
                    Answer(text: "Trying my best", type: .spriderman),
                    Answer(text: "Minimizing casualties", type: .captain)
                          ]),
        Question(text: "Would you consider yourself more of a thinker or a fighter?",
                 type: .ranged,
                 answers: [
                       Answer(text: "Thinker", type: .tony),
                       Answer(text: "Moreso thinker", type: .spriderman),
                       Answer(text: "Moreso Fighter", type: .hulk),
                       Answer(text: "Fighter", type: .captain),
                            ]),
        Question(text: "How do you feel about secret identities?",
                 type: .single,
                 answers: [
                    Answer(text: "Needed to keep family safe", type: .spriderman),
                    Answer(text: "Good for some but not me", type: .captain),
                    Answer(text: "A luxury", type: .hulk),
                    Answer(text: "Not Necessary", type: .tony)
                          ]),
        Question(text: "Which foods do you like?",
                 type:.multiple,
                 answers: [
                    Answer(text: "Apple Pie", type: .captain),
                    Answer(text: "NY-Style Pizza", type: .spriderman),
                    Answer(text: "Cheeseburgers", type: .tony),
                    Answer(text: "Tacos", type: .hulk)
                          ]),
    ]
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
      if segue.identifier == "marvelResults" {
          let resultsViewController = segue.destination as! MarvelResultsViewController
          resultsViewController.responses = answersChosen
      }
    struct Question {
            var text: String
            var type: responseType
            var answers: [Answer]
        }
    enum responseType {
            case single, multiple, ranged
        }
    struct Answer {
        var text: String
        var type: marvelType
    }
    enum marvelType: String {
        case hulk = "Hulk", tony = "Iron Man", spriderman = "Spider-Man", captain = "Captain America"
        var definition: String {
            switch self {
            case .hulk:
                return "You son of a test tube, you're the hulk! You have parts of yourself in direct opposition and yet they make you the unique person that you are."
            case .tony:
                return "You are intelligent, focused, and care about the people closest to you. Go get a cheeseburger to celebrate!"
            case .spriderman:
                return "You are full of energy and live life to the fullest. However, you never let your love of fun interrupt your determination to do the right thing."
            case .captain:
                return "You are a loyal and trustworthy person that is true to your principles. You stick up for the needy and are known for doing the right thing even when it's hard."
            }
        }
    }
}
}
