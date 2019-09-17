//  管理员界面---成绩信息界面controller
import UIKit
import CoreData

class GradeTableViewController: UITableViewController {
    var searchFactor = ""
    var snamelist=[String](repeating: "StudentName", count: 99)
    var cnamelist=[String](repeating: "CourseName", count: 99)

    @IBOutlet weak var txtsearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchFactor = ""
        self.tableView!.register(UINib(nibName:"GradeTableViewCell", bundle:nil),
                                 forCellReuseIdentifier:"cell")

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //  列表行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getGradeInfo(factor:searchFactor).count
    }
    
    //  列表行填充
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
            as! GradeTableViewCell
        let cname0 = (getGradeInfo(factor:searchFactor)[indexPath.row].value(forKey: "cname")as? String)!
        let sname0 = (getGradeInfo(factor:searchFactor)[indexPath.row].value(forKey: "sname")as? String)!
        let grade0 = (getGradeInfo(factor:searchFactor)[indexPath.row].value(forKey: "grade")as? String)!
        cell.loadData(cname:cname0 , sname:sname0, grade: grade0)
        snamelist[indexPath.row] = sname0
        cnamelist[indexPath.row] = cname0
        return cell
    }
    //  获取成绩信息函数
    private   func  getGradeInfo(factor:String)->[NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Grade")
        if(factor != ""){
            let predicate = NSPredicate(format: "cname = '"+factor+"' or sname = '"+factor+"'", "")
            fetchRequest.predicate = predicate
        }
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            return fetchedResults!
        } catch  {
            fatalError("Obtain failure")
        }
    }
    //  搜索button
    @IBAction func searchInfo(_ sender: Any) {
        searchFactor = txtsearch.text!
        self.tableView!.reloadData()
    }
    //  删除成绩信息函数
    private func delGrade(cname:String,sname:String){
        let app = UIApplication.shared.delegate as! AppDelegate
        let contexts = app.persistentContainer.viewContext
        let entityName = "Grade"
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: contexts); fetchRequest.entity = entity
        let predicate = NSPredicate.init(format: "cname = '"+cname+"' and sname = '"+sname+"'", "")
        fetchRequest.predicate = predicate
        do {
            let fetchedObjects = try contexts.fetch(fetchRequest) as! [Grade]
            for one: Grade in fetchedObjects { contexts.delete(one)
                app.saveContext() } }
        catch {
            let nserror = error as NSError
            fatalError("Query error： \(nserror), \(nserror.userInfo)")
        }
        
        
    }
    //  右滑删除
    override func  tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "delete"
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            delGrade(cname:cnamelist[indexPath.row],sname:snamelist[indexPath.row])
            self.tableView!.reloadData()
        }
    }


    

}
