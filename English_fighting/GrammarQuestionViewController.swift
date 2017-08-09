//
//  GrammarQuestionViewController.swift
//  English_fighting
//
//  Created by sunado on 8/3/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import UIKit

class GrammarQuestionViewController: AbstractQuestionViewController {
    
    @IBOutlet weak var sentenceCollectionView: UICollectionView!
    @IBOutlet weak var progressView: UIProgressView!
    let cellID = "cell"
    let netWorkHelper = NetWorkHelper()
    var sentenceArr: [String] = []
    
    var wrongPos: [Int] = []
    init(delegate: AnswerDelegate){
        super.init(nibName: "GrammarQuestionViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func perfomrBack(_ sender: UIButton) {
        comfirmEscape()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.setProgress(1, animated: true)
        sentenceCollectionView.delegate = self
        sentenceCollectionView.dataSource = self
        let nib = UINib(nibName: "GrammarCollectionViewCell", bundle: nil)
        sentenceCollectionView.register(nib, forCellWithReuseIdentifier: cellID)
        let id = DataManager.randQuestion(type: DataManager.GRAMMARQUESTION)
        netWorkHelper.loadQuestion(id: id, type:DataManager.GRAMMARQUESTION){ json in
            let question = GrammarQuestion.create(data: json)
            if let question = question {
                self.wrongPos = question.wrongPos
                self.sentenceArr = question.wrongSentence
                print("wrongPos:  \(question.wrongPos)")
                DispatchQueue.main.async {
                    self.sentenceCollectionView.reloadData()
                }
                
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        startCountDown(with: progressView)
    }

}

extension GrammarQuestionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return sentenceArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = sentenceCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? GrammarCollectionViewCell
        let pos = indexPath.row as Int
        
        if let cell = cell {
            cell.wordButton.setTitle(sentenceArr[pos], for: .normal)
            cell.delegate = self
            cell.index = pos
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
}

extension GrammarQuestionViewController: UICollectionViewDelegate {
    
}

extension GrammarQuestionViewController: GrammarAnswerDelegate {
    func send(result: Int){
        print("clicked  \(result)")
        let pos = wrongPos.index(of: result + 1 )
        if let pos = pos {
            wrongPos.remove(at: pos)
            if wrongPos.count == 0 {
                showRightAnswerAlert()
            }
        } else {
            showWrongAnswerAlert()
        }
    }
}
