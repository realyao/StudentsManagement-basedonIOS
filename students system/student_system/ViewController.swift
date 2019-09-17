//  登陆界面controller
import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var textstate: UILabel!
    @IBOutlet weak var textname: UITextField!
    @IBOutlet weak var textnum: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //  登陆管理员界面
    @IBAction func btnLoginManagement(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CourseTabbar") as! UITabBarController
        self.present(vc, animated: true, completion: nil)
    }
    //  登陆学生界面
    @IBAction func btnLogin(_ sender: UIButton) {
        if(login(username:textname.text!,psd:textnum.text!)){
            let singleton = Singleton.sharedInstance()
            singleton.text = textname.text!
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "StudentTabbar") as! UITabBarController
            self.present(vc, animated: true, completion: nil)
        }else{
            textstate.text = "Login failed, please re-enter."
        }
    }
    //  学号姓名匹配判断
    private   func  login(username:String,psd:String)->Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        let predicate = NSPredicate(format: "sname = '"+username+"'", "")
        fetchRequest.predicate = predicate
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                if(results.count > 0){
                    let res = results;
                    let name0  = res[0].value(forKey: "snum") as? String
                    if(name0 == psd){
                        return true
                    }
                }
            }
        } catch  {
            fatalError("Obtain failure")
        }
        return false
    }
}

