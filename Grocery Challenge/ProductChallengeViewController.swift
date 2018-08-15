//
//  ProductChallengeViewController.swift
//  Grocery Challenge
//
//  Created by Michael Dautermann on 7/18/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import UIKit
import SDWebImage

class ProductChallengeViewController: UIViewController {

    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var product1Button : UIButton!
    @IBOutlet var product2Button : UIButton!
    @IBOutlet var product3Button : UIButton!
    @IBOutlet var product4Button : UIButton!
    @IBOutlet var submitButton : UIButton!
    
    var questionNumber = 0 {
        didSet {
            self.title = "Question # \(questionNumber+1)"
        }
    }
    
    var answerNumber : Int?
    
    var productQuestion : Question? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if (self?.isViewLoaded == true) {
                    if let question = self?.productQuestion {
                        self?.nameLabel.text = question.query
                        self?.product1Button.sd_setImage(with: question.answers[0].url, for: .normal, completed: nil)
                        self?.product2Button.sd_setImage(with: question.answers[1].url, for: .normal, completed: nil)
                        self?.product3Button.sd_setImage(with: question.answers[2].url, for: .normal, completed: nil)
                        self?.product4Button.sd_setImage(with: question.answers[3].url, for: .normal, completed: nil)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let preloadedProductQuestion = productQuestion {
            productQuestion = preloadedProductQuestion
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(animated)
        submitButton.isEnabled = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let rootViewController = self.navigationController!.viewControllers.first as? ViewController {
            
            guard let productQuestion = productQuestion else {
                Swift.print("how did I get this far without having a valid product question????")
                return false
            }
            guard let answerNumber = answerNumber else {
                Swift.print("would be nice to display a UIAlertController saying I didn't select anything")
                return false
            }

            if (productQuestion.answers[answerNumber].correct == true) {
                Swift.print("correct answer!")
                rootViewController.correctAnswers = rootViewController.correctAnswers+1
            } else {
                Swift.print("incorrect answer!")
            }

            let newQuestionNumber = self.questionNumber+1
            if (newQuestionNumber >= rootViewController.questions.count)
            {
                self.navigationController?.popToRootViewController(animated: true)
                return false
            }
        }
        return true
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let rootViewController = self.navigationController!.viewControllers.first as? ViewController {
            if let questionVC = segue.destination as? ProductChallengeViewController {
                let newQuestionNumber = self.questionNumber+1
                questionVC.questionNumber = newQuestionNumber
                Swift.print("about to load question number \(questionVC.questionNumber) out of \(rootViewController.questions.count)")
                if(newQuestionNumber < rootViewController.questions.count)
                {
                    // the title is 1 based while the question array is zero based
                    let question = rootViewController.questions[newQuestionNumber]
                    questionVC.productQuestion = question
                } else {
                    Swift.print("shouldPerformSegue should have returned false so we shouldn't be here")
                }
            }
        }
    }

    @IBAction func makeChoice(sender : UIButton) {
        answerNumber = sender.tag
        submitButton.isEnabled = true
        
        product1Button.isSelected = (answerNumber == 0)
        product2Button.isSelected = (answerNumber == 1)
        product3Button.isSelected = (answerNumber == 2)
        product4Button.isSelected = (answerNumber == 3)
    }
}
