//
//  QuestionsViewController.swift
//  Trivia
//
//  Created by Michael on 23/06/2024.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionCategoryLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOneLabel: UILabel!
    @IBOutlet weak var answerTwoLabel: UILabel!
    @IBOutlet weak var answerThreeLabel: UILabel!
    @IBOutlet weak var answerFourLabel: UILabel!
    @IBOutlet weak var answerOneView: UIView!
    @IBOutlet weak var answerTwoView: UIView!
    @IBOutlet weak var ansswerThreeView: UIView!
    @IBOutlet weak var answerFourView: UIView!
    
    
    var questions = [Question]()
    var currentQuestionIndex = -1
    var questionNumber = 0
    var currentScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        setupGestureToAnswersView()
        questions = createMockData()
        moveToNextQuestion()

        // Do any additional setup after loading the view.
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                                UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupGestureToAnswersView() {
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector (self.didAnswerOneTab(_:)))
        self.answerOneView.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.didAnswerTwoTab(_:)))
        self.answerTwoView.addGestureRecognizer(gesture2)
        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector (self.didAnswerThreeTab(_:)))
        self.ansswerThreeView.addGestureRecognizer(gesture3)
        let gesture4 = UITapGestureRecognizer(target: self, action:  #selector (self.didAnswerFourTab(_:)))
        self.answerFourView.addGestureRecognizer(gesture4)
    }
    
    @objc func didAnswerOneTab(_ sender:UITapGestureRecognizer){
        let currentQuestion = questions[currentQuestionIndex]
        if currentQuestion.answer1.isRightOption {
            currentScore += 1
        }
        moveToNextQuestion()
    }
    
    @objc func didAnswerTwoTab(_ sender:UITapGestureRecognizer){
        let currentQuestion = questions[currentQuestionIndex]
        if currentQuestion.answer2.isRightOption {
            currentScore += 1
        }
        moveToNextQuestion()
    }
    
    @objc func didAnswerThreeTab(_ sender:UITapGestureRecognizer){
        let currentQuestion = questions[currentQuestionIndex]
        if currentQuestion.answer3.isRightOption {
            currentScore += 1
        }
        moveToNextQuestion()
    }
    
    @objc func didAnswerFourTab(_ sender:UITapGestureRecognizer){
        let currentQuestion = questions[currentQuestionIndex]
        if currentQuestion.answer4.isRightOption {
            currentScore += 1
        }
        moveToNextQuestion()
    }
    
    private func moveToNextQuestion(){
        currentQuestionIndex += 1
        if currentQuestionIndex >= questions.count {
            currentQuestionIndex = 0
        }
        questionNumber += 1
        
        if questionNumber > 3 {
            showFinalScore()

        } else {
            configure(with: questions[currentQuestionIndex])
        }
        
        
    }
    
    
    
    private func showFinalScore() {
        let gameOverAlertController = UIAlertController(title: "Game Over!", message: "Final Score: \(currentScore)/3", preferredStyle: .alert)
                
                
        let OKAction = UIAlertAction(title: "Reset", style: .default) { (action:UIAlertAction!) in
            self.resetQuestion()
            self.moveToNextQuestion()
        }
                
        gameOverAlertController.addAction(OKAction)
                
        self.present(gameOverAlertController, animated: true, completion:nil)
    }
    
    private func resetQuestion() {
        questionNumber = 0
        currentScore = 0
    }
    
    private func configure(with question: Question) {
        questionNumberLabel.text = "Question: \(questionNumber)/3"
        questionCategoryLabel.text = "Category: \(question.category.name)"
        questionLabel.text = question.question
        answerOneLabel.text = question.answer1.option
        answerTwoLabel.text = question.answer2.option
        answerThreeLabel.text = question.answer3.option
        answerFourLabel.text = question.answer4.option
    }
    
    private func createMockData() -> [Question] {
        var questions = [Question] ()
        questions.append(Question(question: "Who is known as the 'King of Pop'?",
                                  category: .music,
                                  answer1: Option(option: "Prince", isRightOption: false),
                                  answer2: Option(option: "Elvis Presley", isRightOption: false),
                                  answer3: Option(option: "Michael Jackson", isRightOption: true),
                                  answer4: Option(option: "Freddie Mercury", isRightOption: false)))

        questions.append(Question(question: "Which artist painted the 'Mona Lisa'?",
                                  category: .art,
                                  answer1: Option(option: "Claude Monet", isRightOption: false),
                                  answer2: Option(option: "Vincent van Gogh", isRightOption: false),
                                  answer3: Option(option: "Pablo Picasso", isRightOption: false),
                                  answer4: Option(option: "Leonardo da Vinci", isRightOption: true)))

        questions.append(Question(question: "Which country won the FIFA World Cup in 2018?",
                                  category: .football,
                                  answer1: Option(option: "Croatia", isRightOption: false),
                                  answer2: Option(option: "France", isRightOption: true),
                                  answer3: Option(option: "Brazil", isRightOption: false),
                                  answer4: Option(option: "Germany", isRightOption: false)))

        questions.append(Question(question: "Who directed the movie 'Inception'?",
                                  category: .movies,
                                  answer1: Option(option: "Christopher Nolan", isRightOption: true),
                                  answer2: Option(option: "Steven Spielberg", isRightOption: false),
                                  answer3: Option(option: "James Cameron", isRightOption: false),
                                  answer4: Option(option: "Quentin Tarantino", isRightOption: false)))

        questions.append(Question(question: "Who is the lead singer of the band 'Queen'?",
                                  category: .music,
                                  answer1: Option(option: "Bono", isRightOption: false),
                                  answer2: Option(option: "David Bowie", isRightOption: false),
                                  answer3: Option(option: "Freddie Mercury", isRightOption: true),
                                  answer4: Option(option: "Mick Jagger", isRightOption: false)))

        questions.append(Question(question: "What style of art is Salvador Dalí known for?",
                                  category: .art,
                                  answer1: Option(option: "Impressionism", isRightOption: false),
                                  answer2: Option(option: "Surrealism", isRightOption: true),
                                  answer3: Option(option: "Cubism", isRightOption: false),
                                  answer4: Option(option: "Expressionism", isRightOption: false)))

        questions.append(Question(question: "Which player has won the most Ballon d'Or awards?",
                                  category: .football,
                                  answer1: Option(option: "Lionel Messi", isRightOption: true),
                                  answer2: Option(option: "Cristiano Ronaldo", isRightOption: false),
                                  answer3: Option(option: "Zinedine Zidane", isRightOption: false),
                                  answer4: Option(option: "Ronaldinho", isRightOption: false)))

        questions.append(Question(question: "Who played the character of 'Forrest Gump'?",
                                  category: .movies,
                                  answer1: Option(option: "Johnny Depp", isRightOption: false),
                                  answer2: Option(option: "Brad Pitt", isRightOption: false),
                                  answer3: Option(option: "Tom Hanks", isRightOption: true),
                                  answer4: Option(option: "Leonardo DiCaprio", isRightOption: false)))

        questions.append(Question(question: "Which composer wrote the 'Fifth Symphony'?",
                                  category: .music,
                                  answer1: Option(option: "Franz Schubert", isRightOption: false),
                                  answer2: Option(option: "Johann Sebastian Bach", isRightOption: false),
                                  answer3: Option(option: "Wolfgang Amadeus Mozart", isRightOption: false),
                                  answer4: Option(option: "Ludwig van Beethoven", isRightOption: true)))

        questions.append(Question(question: "Which artist is known for the painting 'Starry Night'?",
                                  category: .art,
                                  answer1: Option(option: "Vincent van Gogh", isRightOption: true),
                                  answer2: Option(option: "Paul Cézanne", isRightOption: false),
                                  answer3: Option(option: "Henri Matisse", isRightOption: false),
                                  answer4: Option(option: "Edvard Munch", isRightOption: false)))

        questions.append(Question(question: "Which country has won the most FIFA World Cups?",
                                  category: .football,
                                  answer1: Option(option: "Germany", isRightOption: false),
                                  answer2: Option(option: "Brazil", isRightOption: true),
                                  answer3: Option(option: "Italy", isRightOption: false),
                                  answer4: Option(option: "Argentina", isRightOption: false)))

        questions.append(Question(question: "Who played the character of 'Jack' in 'Titanic'?",
                                  category: .movies,
                                  answer1: Option(option: "Tom Cruise", isRightOption: false),
                                  answer2: Option(option: "Matt Damon", isRightOption: false),
                                  answer3: Option(option: "Ben Affleck", isRightOption: false),
                                  answer4: Option(option: "Leonardo DiCaprio", isRightOption: true)))

        
        return questions
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
