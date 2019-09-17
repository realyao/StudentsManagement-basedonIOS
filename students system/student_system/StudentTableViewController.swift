//  学生界面----个人课程界面
import UIKit
import CoreData

class StudentTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.register(UINib(nibName:"StudentTableViewCell", bundle:nil),
                                 forCellReuseIdentifier:"cell")

    }

    @IBAction func btnExit(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewCon") as! ViewController
        self.present(vc, animated: true, completion: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getCourseInfo().count
    }
    
    //  列表填充函数
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
            as! StudentTableViewCell
        let name0 = (getCourseInfo()[indexPath.row].value(forKey: "cname")as? String)!
        let num0 = (getCourseInfo()[indexPath.row].value(forKey: "cnum")as? String)!
        let credit0 = (getCourseInfo()[indexPath.row].value(forKey: "ccredit")as? String)!
        cell.loadData(name:name0 , num:num0, credit: credit0)
     
        return cell
    }
    //  获取课程信息函数
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

}
