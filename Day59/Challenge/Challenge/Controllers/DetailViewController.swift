//
//  DetailViewController.swift
//  Challenge
//
//  Created by Nicholas on 21/05/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var regionLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var diallingLabel: UILabel!
    @IBOutlet var isoLabel: UILabel!
    
    var name: String?
    var code: String?
    var capital: String?
    var region: String?
    var currency: Currency?
    var language: Language?
    var flag: String?
    var dialling_code: String?
    var isoCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        nameLabel.numberOfLines = 0
        
        nameLabel.text = "Name: \(name ?? "No Name")"
        codeLabel.text = "Code: \(code ?? "No Code")"
        capitalLabel.text = "Capital: \(capital ?? "No Capital")"
        regionLabel.text = "Region: \(region ?? "No Region")"
        currencyLabel.text = "Currency: \(currency?.name ?? "No Currency")"
        languageLabel.text = "Language: \(language?.name ?? "No Language")"
        diallingLabel.text = "Dialling Code: \(dialling_code ?? "No Dialling Code")"
        isoLabel.text = "iSO Code: \(isoCode ?? "No iSO Code")"
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
