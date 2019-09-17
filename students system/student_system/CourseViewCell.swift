//  课程信息列表cell

import UIKit

class CourseViewCell: UITableViewCell {

    @IBOutlet weak var txtccredit: UILabel!
    @IBOutlet weak var txtcnum: UILabel!
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
    func loadData(name:String,num:String,credit:String){
        txtcname.text = name;
        txtcnum.text = "Course Num:"
        txtcnum.text?.append(num)
        txtccredit.text = "Credit:"
        txtccredit.text?.append(credit)
    }

    
}
