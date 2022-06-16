//
//  AddViewController.swift
//  todo_list
//
//  Created by Rakha A on 16/06/22.
//

import Foundation
import UIKit

class AddViewController:UIViewController{
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var subtitleField: UITextField!
    
    @IBOutlet weak var taskField: UITextField!
    
    var viewController:ViewController?
    
    var sql:SQLite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sql = SQLite()
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        let title = titleField.text ?? ""
        let subtitle = subtitleField.text ?? ""
        let task = taskField.text ?? ""
        if (title==""){
            showAlert(isi: "Mohon isi title")
            return
        }
        if(subtitle==""){
            showAlert(isi: "Mohon isi subtitle")
            return
        }
       
        sql?.insertTodoList(title: title, subTitle: subtitle, task: task)
        viewController?.populate()
        berhasil()
    }
    func berhasil(){
     
        let alert=UIAlertController(title: "Alert", message: "Berhasil", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
                guard let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController else {return}
                self.navigationController?.popViewController(animated: true)
             
                
            }))
            self.present(alert,animated: true,completion: nil)
        
    }
    func showAlert(isi:String){
        let alert=UIAlertController(title: "Alert", message: isi, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert,animated: true,completion: nil)
    }
    
}
