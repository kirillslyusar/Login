//
//  ViewController.swift
//  Login
//
//  Created by Кирилл Слюсарь on 12.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    private let user = "User"
    private let password = "Password"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else { return }
        welcomeVC.user = user
    } // создаем элемент класса, приводим destination у segue к типу экрана, на который переходи (WelcomeViewController) . Затем обращаемся к свойству user и передаем туда user
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    } // метод, который открывает клавиатуру
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard userNameTextField.text == user, passwordTextField.text == password else {
            showAlert(
                title: "Invalid login or password",
                message: "Please, enter correct login and password",
                textField: passwordTextField // скидываем пароль
            )
            return false
        }
        return true
    } // Системный метод shouldPerformSegue, который возвращает бул при выполнении проверки, которая описана в guard. Если все ок, переход, если нет, то showAlert и false
    
    
    
    @IBAction func logInPressed(_ sender: Any) {
        
        guard userNameTextField.text == user, passwordTextField.text == password else { // проверяем соответсвие данных введеных в полях, если есть несоответсвие то вызывается showAlert
            showAlert(
                title: "Invalid login or password",
                message: "Please, enter correct login and password",
                textField: passwordTextField
            )
            return
        }
        performSegue(withIdentifier: "openWelcomeVC", sender: nil) // если данные введены корректно и showAlert не сработан, то запускаем системный метод performSegue. Это называется программныей переход, который происходит от Вью а не от Кнопки, при условии выполнения, тут это корректность данных в userNameTextField и passwordTextField
    }

    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {

        }
    
    
    @IBAction func forgotRegisterData(_ sender: UIButton) {
        sender.tag == 0
            ? showAlert(title: "Oops!", message: "Your name is \(user) 😉")
            : showAlert(title: "Oops!", message: "Your password is \(password) 😉")
    } // срабатывает при нажатие на логаут и стирает информацию в строках
    

    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
