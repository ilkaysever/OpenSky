//
//  DetailVC.swift
//  OpenSky
//
//  Created by İlkay Sever on 18.04.2023.
//

import UIKit
import PanModal

//protocol CustomAlertDelegate: AnyObject {
//    func didTappedFirstButton()
//    func didTappedSecondButton()
//    func didTappedThirdButton()
//}

enum BottomSheetType {
    case flyInfo
    case airport
}

final class DetailVC: BaseViewController {
    
    //weak var delegate: CustomAlertDelegate?
    var bottomSheetType: BottomSheetType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        //        switch customAlertType {
        //        case .projectList:
        //            firstButton.backgroundColor = AppColors.overlayDark
        //            firstButton.setTitle("update_project".localized, for: .normal)
        //            firstButton.titleLabel?.textColor = AppColors.primaryDark
        //            firstButton.titleLabel?.font = AppFonts.SfProDisplayRegular16
        //            firstButton.addCornerRadius(radius: 8)
        //
        //            secondButton.backgroundColor = AppColors.overlayDark
        //            secondButton.setTitle("remove".localized, for: .normal)
        //            secondButton.titleLabel?.textColor = AppColors.red01Dark
        //            secondButton.titleLabel?.font = AppFonts.SfProDisplayRegular16
        //            secondButton.addCornerRadius(radius: 8)
        //
        //            thirdButton.backgroundColor = AppColors.overlayDark
        //            thirdButton.setTitle("delete_project".localized, for: .normal)
        //            thirdButton.titleLabel?.textColor = AppColors.red01Dark
        //            thirdButton.titleLabel?.font = AppFonts.SfProDisplayRegular16
        //            thirdButton.addCornerRadius(radius: 8)
        //
        //            cancelButton.backgroundColor = AppColors.pink
        //            cancelButton.setTitle("cancel".localized, for: .normal)
        //            cancelButton.titleLabel?.textColor = AppColors.primaryDark
        //            cancelButton.titleLabel?.font = AppFonts.SfProDisplaySemiBold16
        //            cancelButton.setCornerButton()
        //
        //        case .favoriteList:
        //            firstButton.backgroundColor = AppColors.overlayDark
        //            firstButton.setTitle("edit_list".localized, for: .normal)
        //            firstButton.titleLabel?.textColor = AppColors.primaryDark
        //            firstButton.titleLabel?.font = AppFonts.SfProDisplayRegular16
        //            firstButton.addCornerRadius(radius: 8)
        //
        //            secondButton.isHidden = true
        ////            secondButton.backgroundColor = AppColors.overlayDark
        ////            secondButton.setTitle("edit_list_content".localized, for: .normal)
        ////            secondButton.titleLabel?.textColor = AppColors.red01Dark
        ////            secondButton.titleLabel?.font = AppFonts.SfProDisplayRegular16
        ////            secondButton.addCornerRadius(radius: 8)
        //
        //            thirdButton.backgroundColor = AppColors.overlayDark
        //            thirdButton.setTitle("delete_list".localized, for: .normal)
        //            thirdButton.titleLabel?.textColor = AppColors.red01Dark
        //            thirdButton.titleLabel?.font = AppFonts.SfProDisplayRegular16
        //            thirdButton.addCornerRadius(radius: 8)
        //
        //            cancelButton.backgroundColor = AppColors.pink
        //            cancelButton.setTitle("cancel".localized, for: .normal)
        //            cancelButton.titleLabel?.textColor = AppColors.primaryDark
        //            cancelButton.titleLabel?.font = AppFonts.SfProDisplaySemiBold16
        //            cancelButton.setCornerButton()
        //        case .orderUploadPhoto:
        //            firstButton.backgroundColor = AppColors.overlayDark
        //            firstButton.setTitle("take_photo".localized, for: .normal)
        //            firstButton.titleLabel?.textColor = AppColors.primaryDark
        //            firstButton.titleLabel?.font = AppFonts.SfProDisplayRegular16
        //            firstButton.addCornerRadius(radius: 8)
        //
        //            secondButton.setTitleColor(AppColors.primaryDark, for: .normal)
        //            secondButton.backgroundColor = AppColors.overlayDark
        //            secondButton.setTitle("upload_galery".localized, for: .normal)
        //            secondButton.titleLabel?.font = AppFonts.SfProDisplayRegular16
        //            secondButton.addCornerRadius(radius: 8)
        //
        //            thirdButton.setTitleColor(AppColors.primaryDark, for: .normal)
        //            thirdButton.backgroundColor = AppColors.overlayDark
        //            thirdButton.setTitle("remove_photo".localized, for: .normal)
        //            thirdButton.titleLabel?.font = AppFonts.SfProDisplayRegular16
        //            thirdButton.addCornerRadius(radius: 8)
        //
        //            cancelButton.backgroundColor = AppColors.pink
        //            cancelButton.setTitle("cancel".localized, for: .normal)
        //            cancelButton.titleLabel?.textColor = AppColors.primaryDark
        //            cancelButton.titleLabel?.font = AppFonts.SfProDisplaySemiBold16
        //            cancelButton.setCornerButton()
        //
        //        default:
        //            break
        //        }
        
    }
    
}

extension DetailVC: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(250)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(250)
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
