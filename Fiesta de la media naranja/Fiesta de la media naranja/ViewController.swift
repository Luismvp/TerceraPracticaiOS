//
//  ViewController.swift
//  Fiesta de la media naranja
//
//  Created by Luis Martin de Vidales Palomero on 18/10/18.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultadoLabel: UILabel!
    @IBOutlet weak var numeroLabel: UILabel!
    var fecha = Date()
    var loveDate = Date()
    var fechaComparable = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultUser = UserDefaults.standard
        if let myBirthday = defaultUser.object(forKey: "fecha") as? Date{
            fecha = (myBirthday)
        }
        if let myLovedate = defaultUser.object(forKey: "fechaC") as? Date{
            loveDate = (myLovedate)
        }
        
        if loveDate != fechaComparable && fecha != fechaComparable{
            resultadoLabel.alpha=1
            numeroLabel.alpha=1
            let intervalo = loveDate.timeIntervalSince(fecha)
            var lover = loveDate
            lover.addTimeInterval(intervalo)
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            numeroLabel.text = df.string(from: lover)
        }else{
            resultadoLabel.alpha=0
            numeroLabel.alpha=0
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Fecha de nacimiento"{
            if let bvc = segue.destination as? NacimientoViewController{
                if bvc.fechaActual != nil && (bvc.fechaActual != fecha){
                    return
                }else{
                    bvc.fechaActual = fecha
                    bvc.fechaYa=loveDate
                    bvc.fechaConocida = fechaComparable
                }
            }
            
        }
        
    }
    @IBAction func Cancelar(_ segue: UIStoryboardSegue){
        if let bvc = segue.source as? ConocidoViewController{
            if bvc.fechaN != fecha{
                fecha = bvc.fechaN!
                return
            }else{
                bvc.fechaN = fecha
            }
        }
    }
    @IBAction func Calculo(_ segue: UIStoryboardSegue){
        resultadoLabel.alpha=1
        numeroLabel.alpha=1
        if let bvc = segue.source as? ConocidoViewController{
            loveDate = bvc.fechaC.date
            fecha = bvc.fechaN!
            let intervalo = loveDate.timeIntervalSince(fecha)
            var lover = loveDate
            lover.addTimeInterval(intervalo)
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            
            numeroLabel.text = df.string(from: lover)
        }
        
        
    }
}

