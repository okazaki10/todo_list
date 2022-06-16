//
//  ViewController.swift
//  todo_list
//
//  Created by Rakha A on 16/06/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todoList:[TodoModel?] = []
    
    @IBOutlet weak var addButton: UIButton!    
    
    var sql:SQLite?
    @IBOutlet weak var listTable: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("sadssadss")
   
        listTable.delegate=self
        listTable.dataSource=self
       
        
        sql = SQLite()
        populate()
      
    }
    
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        let p = sender.location(in: listTable)
         let indexPath = listTable.indexPathForRow(at: p)
         if indexPath == nil {
             print("Long press on table view, not row.")
         } else if sender.state == UIGestureRecognizer.State.began {
             print("Long press on row, at \(indexPath!.row)")
             deleteData(id: todoList[indexPath!.row]!.id)
         }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as? AddViewController
        
        destinationVC?.viewController=self
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTable",for: indexPath) as! ListTable
        
        // set the text from the data model
        cell.titleLabel?.text = todoList[indexPath.row]?.title
        cell.subtitleLabel?.text = todoList[indexPath.row]?.subtitle
        cell.taskLabel?.text = todoList[indexPath.row]?.task ?? ""
return cell
    }
    
    func populate(){
        todoList=[]
        
        guard let sql = sql!.getTodoList() else {return}
        
        for row in sql{
            print(row)
            todoList.append(TodoModel(id: row[0] as! Int64, title: row[1] as! String, subtitle: row[2] as! String, task: row[3] as? String))
        }
        listTable.reloadData()
    }
    func deleteData(id:Int64){
        showAlert(isi: "Apakah anda yakin ingin menghapus data ini?",id: id)
    }
    func showAlert(isi:String,id:Int64){
        let refreshAlert = UIAlertController(title: "Alert", message: isi, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print(id)
            self.sql?.deleteTodoList(id: id)
            self.populate()
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))

        present(refreshAlert, animated: true, completion: nil)
    }

    

}

