import UIKit
import NFFontNunito

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIFont.registerNunito()
        
        label.font = UIFont.nunito(ofSize: 12.0, style: .extraBold)
    }


}

