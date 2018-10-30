//
//  ConocidoViewController.swift
//  Fiesta de la media naranja
//
//  Created by Luis Martin de Vidales Palomero on 18/10/18.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class ConocidoViewController: UIViewController {
    var fechaN:Date?
    var fechaYa:Date?
    var fechaComparable:Date?
    @IBOutlet weak var fechaElegida: UILabel!
    @IBOutlet weak var cambiaFecha: UIButton!
    @IBOutlet weak var fechaC: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stackDate: UIStackView!
    @IBOutlet weak var stackMayor: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fechaYa! != fechaComparable{
            fechaElegida.isHidden = false
            fechaC.isHidden = true
            cambiaFecha.isHidden = false
            fechaC.setDate(fechaYa!, animated: true)
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            fechaElegida.text = df.string(from: fechaYa!)
            label.text = "Lo conociste el:"
            stackDate.distribution = .fillEqually
            stackMayor.distribution = .fill
        }else{
            fechaC.setDate(fechaYa!, animated: true)
            fechaElegida.isHidden = true
            cambiaFecha.isHidden = true
            stackDate.distribution = .fill
            stackDate.spacing = 10
            stackMayor.distribution = .fillEqually
        }
    }
    @IBAction func cambiarFecha(_ sender: UIButton) {
        fechaElegida.isHidden = true
        cambiaFecha.isHidden = true
        fechaC.isHidden = false
        label.text = "Introduce tu fecha de nacimiento:"
        stackDate.distribution = .fill
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Terminasegue"{
            if fechaN! > fechaC.date || fechaC.date > Date(){
                let alert = UIAlertController(title: "MAL", message: "baja del Delorian", preferredStyle:.alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default))
                present(alert, animated:true)
                return false
            }else{
                return true
            }
        }else{
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if fechaC.isHidden {
            if let bvc = segue.destination as? ViewController{
                bvc.loveDate = fechaYa!
            }
        }else{
            if let bvc = segue.destination as? ViewController{
                let defaultuser = UserDefaults.standard
                defaultuser.set(fechaC.date, forKey:"fechaC")
                bvc.loveDate = fechaC.date
            }
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
}
