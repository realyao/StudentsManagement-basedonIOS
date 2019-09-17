//  成绩信息列表cell
import UIKit

class GradeTableViewCell: UITableViewCell {

    @IBOutlet weak var txtgrade: UILabel!
    @IBOutlet weak var txtsname: UILabel!
    @IBOutlet weak var txtcname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //  cell填充函数
    func loadData(cname:String,sname:String,grade:String){
        txtcname.text = cname
        txtsname.text = sname
        txtgrade.text = grade
        if(grade != "Not entered"){
               txtgrade.text?.append("points")
        }
    }
}
