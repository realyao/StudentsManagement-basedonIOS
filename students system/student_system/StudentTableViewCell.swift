//  学生界面----个人课程界面列表cell
import UIKit
import CoreData

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var btnadd: UIButton!
    @IBOutlet weak var txtgrade: UILabel!
    @IBOutlet weak var txtccredit: UILabel!
    @IBOutlet weak var txtcnum: UILabel!
    @IBOutlet weak var txtcname: UILabel!
    var sname = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        let singleton = Singleton.sharedInstance()
        sname = singleton.text
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    //  填充cell函数
    func loadData(name:String,num:String,credit:String){
        txtcname.text = name;
        txtcnum.text?.append(num)
        txtccredit.text?.append(credit)
        if(getGradeInfo(sname:sname,cname:name).count>0){
            txtgrade.text = getGradeInfo(sname:sname,cname:name)[0].value(forKey: "grade")as? String
            btnadd.isHidden = true
        }else{
            txtgrade.isHidden = true
        }
        if( txtgrade.text != "Not Entered"){
                txtgrade.text?.append("points")
        }
    }
    //  获取成绩信息函数
    private   func  getGradeInfo(sname:String,cname:String)->[NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Grade")
        let predicate = NSPredicate(format: "cname = '"+cname+"' and sname = '"+sname+"'","")
        fetchRequest.predicate = predicate
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            return fetchedResults!
        } catch  {
            fatalError("Obtain failure")
        }
    }

    
    //  cell中选课button
    @IBAction func addCourse(_ sender: UIButton) {
        txtgrade.isHidden = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Grade", in: managedObectContext)
        let course = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        course.setValue(sname, forKey: "sname")
        course.setValue("Not Entered", forKey: "grade")
        course.setValue(txtcname.text, forKey: "cname")
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("Unable to save")
        }
        btnadd.isHidden = true
        txtgrade.text = "Not Entered"
    }
    
}
