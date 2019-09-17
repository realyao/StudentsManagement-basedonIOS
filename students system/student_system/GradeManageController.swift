//  管理员界面----成绩录入界面controller
import UIKit
import CoreData

class GradeManageController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
  
    @IBOutlet weak var txtgrade: UITextField!
    @IBOutlet weak var pickercname: UIPickerView!
    @IBOutlet weak var txtsname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        pickercname.delegate = self
        pickercname.dataSource = self
        
    }
    //  pickerView创建
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getCourseInfo().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  getCourseInfo()[row].value(forKey: "cname")as? String
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  获取成绩信息函数
    private   func  getCourseInfo()->[NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
                return fetchedResults!
        } catch  {
            fatalError("Obtain failure")
        }
    }

    @IBAction func btnReturn(_ sender: Any) {
          self.dismiss(animated: true) {}
        
    }
   //  更新成绩信息函数
    @IBAction func btnFinished(_ sender: Any) {
        if(txtsname.text == ""){
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let cname0 = getCourseInfo()[pickercname.selectedRow(inComponent: 0)].value(forKey: "cname")as? String
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Grade")
        fetchRequest.predicate = NSPredicate(format: "cname = '"+cname0!+"'and sname = '"+txtsname.text!+"'", "")
        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
            let fetchObject  = result.finalResult! as! [Grade]
            for res in fetchObject{
                res.grade = self.txtgrade.text
                app.saveContext()
            }
        }
        do {
            try context.execute(asyncFecthRequest)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CourseTabbar") as! UITabBarController
            self.present(vc, animated: true, completion: nil)
        } catch  {
            print("error")
        }
    }

    
}
