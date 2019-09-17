//  管理员界面----课程信息界面controller

import Foundation
import UIKit
import CoreData

class  CourseTableViewController: UITableViewController {
    
    var tablelist=[String](repeating: "CourseName", count: 99)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.register(UINib(nibName:"CourseViewCell", bundle:nil),
                                 forCellReuseIdentifier:"cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //  列表行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getCourseInfo().count
    }
    
    //  填充行
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
            as! CourseViewCell
        let name0 = (getCourseInfo()[indexPath.row].value(forKey: "cname")as? String)!
        let num0 = (getCourseInfo()[indexPath.row].value(forKey: "cnum")as? String)!
        let credit0 = (getCourseInfo()[indexPath.row].value(forKey: "ccredit")as? String)!
        cell.loadData(name:name0 , num:num0, credit: credit0)
        tablelist[indexPath.row] = name0
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
    //  删除课程信息函数
    private func delCourse(cname:String){
        let app = UIApplication.shared.delegate as! AppDelegate
        let contexts = app.persistentContainer.viewContext
        let entityName = "Course"
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: contexts); fetchRequest.entity = entity
        let predicate = NSPredicate.init(format: "cname = '"+cname+"'", "")
        fetchRequest.predicate = predicate
        do {
            let fetchedObjects = try contexts.fetch(fetchRequest) as! [Course]
            for one: Course in fetchedObjects { contexts.delete(one)
                app.saveContext() } }
        catch {
            let nserror = error as NSError
            fatalError("Query error： \(nserror), \(nserror.userInfo)")
        }
        
        
    }
    //  右滑菜单
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
        
            delCourse(cname:tablelist[indexPath.row])
            self.tableView!.reloadData()
        }
    }
    


    
    
    
}
