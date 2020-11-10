//
//  AnimalsDetailViewController.swift
//  AnimalsAPI
//
//  Created by SAM on 2020/11/2.
//

import UIKit

class AnimalsDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var hobbyLabel: UILabel!
    @IBOutlet weak var subtypeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var animal: Animals!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = animal?.name.name_TWzh
        genderLabel.text = animal?.gender
        birthdayLabel.text = animal?.birthday_string
        speciesLabel.text = animal?.species
        hobbyLabel.text = animal?.hobby
        subtypeLabel.text = animal?.subtype
        imageView.image = try! UIImage(data: Data(contentsOf: URL(string: animal!.image_uri)!))
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
