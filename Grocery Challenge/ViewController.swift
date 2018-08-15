//
//  ViewController.swift
//  Grocery Challenge
//
//  Created by Andrew Crookston on 5/14/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let challenge = ChallengeAPI()
    var questions = [Question]()
    var correctAnswers : Int = 0
    var didDisplayQuestions : Bool = false
    @IBOutlet var summaryView : UIView!
    @IBOutlet var numberOfQuestions : UILabel!
    @IBOutlet var numberOfCorrectAnswers : UILabel!
    @IBOutlet var numberOfIncorrectAnswers : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.questions.count > 0 {
            self.summaryView.isHidden = false
            self.numberOfQuestions.text = "Number of questions: \(questions.count)"
            self.numberOfCorrectAnswers.text = "Number Correct: \(correctAnswers)"
            self.numberOfIncorrectAnswers.text = "Number Incorrect: \(questions.count - correctAnswers)"
        } else {
            challenge.allQuestionsAsync { (results) in
                switch(results) {
                case .success(let questions):
                    self.questions = questions
                case .error(let error):
                    Swift.print("some kind of error \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.correctAnswers = 0
        didDisplayQuestions = true
        if let questionVC = segue.destination as? ProductChallengeViewController {
            if questions.count > 0 {
                let question = questions[0]
                questionVC.questionNumber = 0
                questionVC.productQuestion = question
            } else {
                Swift.print("we should always have a question array at this point")
            }
        }
    }
}
