//  管理员界面----课程添加界面controller
import Foundation
import UIKit
import CoreData

class CourseManageController: UIViewController {

    @IBOutlet weak var addNum: UITextField!
    @IBOutlet weak var addName: UITextField!
    @IBOutlet weak var addCredit: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //  返回
    @IBAction func btnReturn(_ sender: UIButton) {
    
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CourseTabbar") as! UITabBarController
        self.present(vc, animated: true, completion: nil)
        
    }
    //  添加课程信息
    @IBAction func btnOk(_ sender: Any) {
        if(addName.text == ""){
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Course", in: managedObectContext)
        let course = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        course.setValue(addName.text, forKey: "cname")
        course.setValue(addCredit.text, forKey: "ccredit")
        course.setValue(addNum.text, forKey: "cnum")
        do {
            try managedObectContext.save()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CourseTabbar") as! UITabBarController
            self.present(vc, animated: true, completion: nil)

        } catch  {
            fatalError("Unable to save")
        }
    }
    
    

}
