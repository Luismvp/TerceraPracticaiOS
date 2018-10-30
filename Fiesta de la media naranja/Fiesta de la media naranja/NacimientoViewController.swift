//
//  NacimientoViewController.swift
//  Fiesta de la media naranja
//
//  Created by Luis Martin de Vidales Palomero on 18/10/18.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class NacimientoViewController: UIViewController {
    
    @IBOutlet weak var stackMayor: UIStackView!
    var fechaActual:Date?
    var fechaConocida:Date?
    var fechaYa:Date?
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var fechaElegida: UILabel!
    @IBOutlet weak var stackDate: UIStackView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cambiaFecha: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if fechaActual! != fechaConocida{
            fechaElegida.isHidden = false
            fecha.isHidden = true
            cambiaFecha.isHidden = false
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            fechaElegida.text = df.string(from: fechaActual!)
            label.text = "Naciste el:"
            stackDate.distribution = .fillEqually
            stackMayor.distribution = .fill
        }else{
            fecha.setDate(fechaActual!, animated: true)
            fechaElegida.isHidden = true
            cambiaFecha.isHidden = true
            stackDate.distribution = .fill
            stackDate.spacing = 10
            stackMayor.distribution = .fillEqually
        }
    }
    @IBAction func CambioFecha(_ sender: UIButton) {
        fechaElegida.isHidden = true
        cambiaFecha.isHidden = true
        fecha.isHidden = false
        label.text = "Introduce tu fecha de nacimiento:"
        stackDate.distribution = .fill
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Fecha de encuentro"{
            if fecha.date > Date(){
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
        if fechaElegida.isHidden{
            if let bvc = segue.destination as? ConocidoViewController{
                let defaultuser = UserDefaults.standard
                defaultuser.set(fecha.date, forKey:"fecha")
                bvc.fechaN = fecha.date
                bvc.fechaYa = fechaYa
                bvc.fechaComparable = fechaConocida
            }
        }else{
            if let bvc = segue.destination as? ConocidoViewController{
                bvc.fechaN = fechaActual
                bvc.fechaYa = fechaYa
                bvc.fechaComparable = fechaConocida
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
