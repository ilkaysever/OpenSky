//
//  DetailVC.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import UIKit
import PanModal

final class DetailVC: BaseViewController {
    
    @IBOutlet weak var pnrLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var geomAltitudeLabel: UILabel!
    @IBOutlet weak var startPointLabel: UILabel!
    @IBOutlet weak var endPointLabel: UILabel!
    
    var stateModel: State? {
        didSet {
            setupUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        pnrLabel.text = stateModel?.callSign?.removingWhitespaces()
        ownerLabel.text = stateModel?.originCountry
        geomAltitudeLabel.text = "\(stateModel?.geoAltitude ?? 0.0)" + "M"
        startPointLabel.text = "N/A"
        endPointLabel.text = "N/A"
    }
    
}

extension DetailVC: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(230)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(230)
    }
    
    var cornerRadius: CGFloat {
        return 20
    }
    
    var shouldRoundTopCorners: Bool {
        return true
    }
    
    var anchorModalToLongForm: Bool {
        return true
    }
    
    var allowsTapToDismiss: Bool {
        return true
    }
    
    var allowsDragToDismiss: Bool{
        return true
    }
    
}
