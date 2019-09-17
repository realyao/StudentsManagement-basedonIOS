
import Foundation
import UIKit
import CoreData
//  注册controller
class RegisterController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var txtstate: UILabel!
    @IBOutlet weak var txttel: UITextField!
    @IBOutlet weak var txtage: UITextField!
    @IBOutlet weak var segsex: UISegmentedControl!
    @IBOutlet weak var txtnum: UITextField!
    @IBOutlet weak var txtname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txttel.delegate=self
        txtage.delegate=self
        txtnum.delegate=self
        txtname.delegate=self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //  输入提醒
    func textFieldDidEndEditing(_ txt: UITextField, reason: UITextFieldDidEndEditingReason) {
        if(txtname.text == ""){
            txtstate.text = "Please enter the student name"
        }else if(txtnum.text == ""){
            txtstate.text = "Please enter the student number"
        }else if(txtage.text == ""){
            txtstate.text = "Please input age"
        }else if(Int(txtage.text!)! <= 0 || Int(txtage.text!)! > 60){
            txtstate.text = "Age input error"
        }else if(txttel.text == ""){
            txtstate.text = "Please enter the telephone"
        }else{
            txtstate.text = ""
        }
      
     
    }
    //  添加学生信息并返回
    @IBAction func backClicked(_ sender: Any) {
        if(txtname.text == ""){
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedObectContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        person.setValue(txtname.text, forKey: "sname")
        person.setValue(txtage.text, forKey: "sage")
        person.setValue(txtnum.text, forKey: "snum")
        person.setValue(txttel.text, forKey: "stel")
        var ssex0 = "sex"
        let index = segsex.selectedSegmentIndex
        if(index == 0){
                ssex0 = "boy"
        }else{
                ssex0 = "girl"
        }
        person.setValue(ssex0, forKey: "ssex")
        do {
            txtstate.text = "Registered successfully"
            try managedObectContext.save()
            self.dismiss(animated: true) {}
        } catch  {
            fatalError("Unable to save")
        }
    }
 
    
    
    
    
}
