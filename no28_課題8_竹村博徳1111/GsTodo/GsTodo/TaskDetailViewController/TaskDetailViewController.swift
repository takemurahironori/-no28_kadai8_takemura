//
//  TaskDetailViewController.swift
//  GsTodo
//
//  Created by Naoki Kameyama on 2020/06/12.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import UIKit
//#warning("ここに PKHUD を import しよう！")
import PKHUD

import TextFieldEffects

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    
    
    
    // TaskListViewControllerからコピーしたtasksとindexPath
    var tasks: [Task] = []
    var selectIndex: Int?
    

    // MARK: - UISetup
    private func setupMemoTextView() {
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.layer.cornerRadius = 3
    }

    private func setupNavigationBar() {
        title = "Task"
        let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
        navigationItem.rightBarButtonItem = rightButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMemoTextView()
        setupNavigationBar()

        // 編集のときTask内容を表示させる
        configureTask()
    }

    // MARK: - Other Method
//    #warning("選択したTaskの表示")
    private func configureTask() {
        if let index = selectIndex {
            titleTextField.text = tasks[index].title
            memoTextView.text = tasks[index].memo
        }
    }

    @objc func tapSaveButton() {
        print("SAve 押した！")
        
//        アンラップする必要あり
        guard let title = titleTextField.text, let index = selectIndex else {
            return}

//        #warning("titleが空白のときのエラー処理")
        
        if title.isEmpty{
            showAlert("title is not Empty")
            return
        }

//        #warning("Editの処理")
        
        
        tasks[index] = Task(title: title, memo: memoTextView.text)
        UserDefaultsRepository.saveToUserDefaults(tasks: tasks)
        HUD.flash(.success, delay: 0.3)
        
        // 前の画面に戻る
        navigationController?.popViewController(animated: true)
    }

//    #warning("アラートを表示するメソッド")
    // アラートを表示するメソッド
    func showAlert(_ text: String){
        let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
