//
//  ViewController.swift
//  Orion_Innovation_TestTask
//
//  Created by Даниил Алексеев on 03.06.2021.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var lenOfResultLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var input: String = ""
    var palindrome: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }
    
    
    func configureTextField(){
        textField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               textField.resignFirstResponder()
               return true;
        }
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func findButton(_ sender: Any) {
        input = textField.text ?? ""
        palindrome = ""
        let vowels: Set<Character> = [",", ".", "/", "?", "!", "-", "—"]
        input = String(input.filter { !" \n\t\r".contains($0) })
        input.removeAll(where: { vowels.contains($0) })
        resultLabel.text = findLongestPalindromicSubstring(input: input.lowercased())
        lenOfResultLabel.text! = "Кол-во символов: \(findLongestPalindromicSubstring(input: input.lowercased()).count)"
    }
    
    
    func findLongestPalindromicSubstring(input: String) -> String {
        guard input.count > 1 else {
            return input
        }
        
        let length = input.count
        var table =  createEmptyTable()
        
        for column in 0...length-1 {
            for row in 0...length-1 where column >= row {
                
                if column == row {
                    table[row][column] = true
                    updateMaxIfNeeded(row: row, column: column)
                }
                
                if (column - row) < 2 && input.byIndex(row) == input.byIndex(column) {
                    table[row][column] = true
                    updateMaxIfNeeded(row: row, column: column)
                }
                
                if (column - 1) > 0 && (row + 1) < length &&
                table[row+1][column-1] == true &&
                    input.byIndex(row) == input.byIndex(column) {
                    table[row][column] = true
                    updateMaxIfNeeded(row: row, column: column)
                }
            }
        }
        
        return palindrome
    }
    
    
    private func updateMaxIfNeeded(row: Int, column: Int) {
        if (column - row + 1) > palindrome.count {
            palindrome = input.substring(from: row, to: column + 1)
        }
    }
    
    
    private func createEmptyTable() -> [[Bool]] {
        var table: [[Bool]] = []
        let row = Array(repeating: false, count: input.count)
        table = Array(repeating: row, count: input.count)
        
        return table
    }
}

extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
