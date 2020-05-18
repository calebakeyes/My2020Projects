//
//  DisneyQuestionViewController.swift
//  Personality Test
//
//  Created by Caleb Keyes on 5/7/20.
//  Copyright © 2020 Caleb Keyes. All rights reserved.
//

import UIKit

var disneyQuestionIndex = 0

class DisneyQuestionViewController: UIViewController {
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
                performSegue(withIdentifier: "disneyResults", sender: nil)
            }
    }
    
    var questions: [Question] = [
        Question(text: "Which of these places would you want to visit?",
                 type:.multiple,
                 answers: [
                    Answer(text: "The moon", type: .buzz),
                    Answer(text: "Beijing", type: .mulan),
                    Answer(text: "Niagra Falls", type: .simba),
                    Answer(text: "The Indian Ocean", type: .genie)
                          ]),
        Question(text: "How lucky are you?",
                 type: .ranged,
                 answers: [
                       Answer(text: "Not at all", type: .simba),
                       Answer(text: "I've been through worse", type: .buzz),
                       Answer(text: "Probably 50/50", type: .mulan),
                       Answer(text: "I make luck", type: .genie),
                            ]),
        Question(text: "How would your best friends describe you?",
                 type:.single,
                 answers: [
                    Answer(text: "Crazy but friendly", type: .genie),
                    Answer(text: "Generous", type: .simba),
                    Answer(text: "Loyal", type: .buzz),
                    Answer(text: "Confident", type: .mulan)
                          ]),
        Question(text: "Your rival is attacking! What do you do?",
                 type: .single,
                 answers: [
                    Answer(text: "Immediately return fire!", type: .buzz),
                    Answer(text: "Get space and strategize", type: .mulan),
                    Answer(text: "Do whatever I need to", type: .simba),
                    Answer(text: "Trust my friends", type: .genie)
                          ]),
        Question(text: "Do you prefer hot weather or cold?",
                 type: .ranged,
                 answers: [
                       Answer(text: "Hot", type: .genie),
                       Answer(text: "Moreso hot", type: .simba),
                       Answer(text: "Moreso cold", type: .buzz),
                       Answer(text: "Cold", type: .mulan),
                            ]),
        Question(text: "What's your favorite type of music?",
                 type: .single,
                 answers: [
                    Answer(text: "Randy Newman", type: .buzz),
                    Answer(text: "Instrumental", type: .mulan),
                    Answer(text: "Comedy", type: .genie),
                    Answer(text: "Foreign Music", type: .simba)
                          ]),
        Question(text: "Which foods do you like?",
                 type:.multiple,
                 answers: [
                    Answer(text: "Tea", type: .buzz),
                    Answer(text: "Rare Steak", type: .simba),
                    Answer(text: "Indian food", type: .genie),
                    Answer(text: "Chinese food", type: .mulan)
                          ]),
    ]
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "disneyResults" {
          let resultsViewController = segue.destination as! DisneyResultsViewController
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
        case hulk = "Hulk", tony = "Iron Man", spriderman = "Spider-Man", captain = "Captain America", simba = "Simba", buzz = "Buzz Lightyear", mulan = "Mulan", genie = "Genie"
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
            case .simba:
                return "Roar! You're the king of the animal kingdom! You are a strong leader who always makes time to have fun with friends."
            case .buzz:
                return "Houston this just in... You're Buzz Lightyear! You are adventurous and always take good care of those closest to you."
            case .mulan:
                    return "You are confident, independent, and wise. You can conquer anything, even an indefinite delay on your live action movie release!"
            case .genie:
                    return "Alakazam! You're the genie! You're playful and fun but always serious when it comes to loving your friends."
            }
        }
    }
}
}
