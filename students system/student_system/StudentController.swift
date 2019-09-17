//  学生界面----个人信息界面controller
import Foundation
import UIKit
import CoreData

class StudentController:UIViewController {
    
    @IBOutlet weak var btntheUpdate: UIButton!
    @IBOutlet weak var txtstate: UILabel!
    @IBOutlet weak var txtstel: UITextField!
    @IBOutlet weak var regssex: UISegmentedControl!
    @IBOutlet weak var txtsage: UITextField!
    @IBOutlet weak var txtsnum: UITextField!
    @IBOutlet weak var txtsname: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        txtstate.text = ""
        let singleton = Singleton.sharedInstance()
        getStudentInfo(name: singleton.text);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //  获取学生信息函数
    private   func  getStudentInfo(name:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        let predicate = NSPredicate(format: "sname = '"+name+"'", "")
        fetchRequest.predicate = predicate
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                if(results.count > 0){
                    let res = results;
                    txtsname.text  = name
                    txtsnum.text  = res[0].value(forKey: "snum") as? String
                    txtsage.text  = res[0].value(forKey: "sage") as? String
                    let sex0  = res[0].value(forKey: "ssex") as? String
                    if(sex0 == "boy"){
                        regssex.selectedSegmentIndex = 0;
                    }else{
                         regssex.selectedSegmentIndex = 1;
                    }
                    txtstel.text  = res[0].value(forKey: "stel") as? String
                }
            }
        } catch  {
            fatalError("Obtain Failure")
        }
    }
    //  更新学生信息函数
    private func updataStudent(name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        fetchRequest.predicate = NSPredicate(format: "sname = '"+name+"'", "")
        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
            let fetchObject  = result.finalResult! as! [Student]
            for res in fetchObject{
                res.snum = self.txtsnum.text
                res.stel = self.txtstel.text
                var ssex0 = "sex"
                let index = self.regssex.selectedSegmentIndex
                if(index == 0){
                    ssex0 = "boy"
                }else{
                    ssex0 = "girl"
                }
                res.ssex = ssex0
                res.sage = self.txtsage.text
                app.saveContext()
            }
        }
        do {
            try context.execute(asyncFecthRequest)
        } catch  {
            print("error")
        }
    }
    //  退出学生界面
    @IBAction func btnExit(_ sender: UIButton) {
        if(btntheUpdate.titleLabel?.text == "OK"){
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ViewCon") as! ViewController
            self.present(vc, animated: true, completion: nil)
        }else{
             txtstate.text = "Please complete the modification!"
        }
    }
    //  更新学生信息button
    var temp = 1;
    @IBAction func btnUpdate(_ sender: UIButton) {
        temp = -temp;
        
        if(temp == -1){
            txtstate.text = "Modifing..."
            btntheUpdate.setTitle("OK", for: UIControlState.normal)
            txtsnum.borderStyle = UITextBorderStyle.roundedRect
            txtstel.borderStyle = UITextBorderStyle.roundedRect
            txtsage.borderStyle = UITextBorderStyle.roundedRect
            txtsnum.isEnabled = true
            txtstel.isEnabled = true
            txtsage.isEnabled = true
            regssex.isEnabled = true
        }else{
            txtstate.text = ""
            btntheUpdate.setTitle("OK", for: UIControlState.normal)
        
            txtsnum.borderStyle = UITextBorderStyle.none
            txtstel.borderStyle = UITextBorderStyle.none
            txtsage.borderStyle = UITextBorderStyle.none
            txtsnum.isEnabled = false
            txtstel.isEnabled = false
            txtsage.isEnabled = false
            regssex.isEnabled = false
            
            updataStudent(name:txtsname.text!);
        }

    }
    
   

}
