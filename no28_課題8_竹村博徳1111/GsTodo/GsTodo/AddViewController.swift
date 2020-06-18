//
//  AddViewController.swift
//  GsTodo
//
//  Created by 竹村博徳 on 2020/06/13.
//  Copyright © 2020 yamamototatsuya. All rights reserved.



import UIKit
import PKHUD

class AddViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var memoTextView: UITextView!
    
        // TaskListViewControllerからコピーしたtasksとindexPath
        var tasks: [Task] = []
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        setupMemoTextView()
        setupNavigationBar()
        
        
        
    }
       
        // MARK: - UISetup
        private func setupMemoTextView() {
            memoTextView.layer.borderWidth = 1
            memoTextView.layer.borderColor = UIColor.lightGray.cgColor
            memoTextView.layer.cornerRadius = 3
        }

        private func setupNavigationBar() {
            title = "Add"
            let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
            navigationItem.rightBarButtonItem = rightButtonItem
        }

      
        // MARK: - Other Method
       @objc func tapSaveButton() {
        print("saveボタン押したよ！")
        
        guard let title = titleTextField.text else {return}
        //#warning("titleが空白のときのエラー処理")
            
            if title.isEmpty{
                print(title,"から！！！")
                HUD.flash(.labeledError(title: nil, subtitle:"タイトルから！"),
                          delay: 1)
                return
            }

//            #warning("tasksにtaskを追加する処理")
        let task = Task(title: title, memo: memoTextView.text)
        tasks.append(task)
        UserDefaultsRepository.saveToUserDefaults(tasks: tasks)
        
        HUD.flash(.success, delay:0.3)
            // 前の画面に戻る
            navigationController?.popViewController(animated: true)
        }

        //#warning("アラートを表示するメソッド")
        // アラートを表示するメソッド
        func showAlert(_ text: String){
            let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
    }

    
 
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


