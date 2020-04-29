//
//  DispEditColorViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/29.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class DispEditColorViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var cancelButtonView: UIButton!
    @IBOutlet weak var finishButtonView: UIButton!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorTitle: UILabel!
    @IBOutlet weak var blueColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var redColorSlider: UISlider!
    
    // MARK: - Properties
    var colorCode = RGBColorCode(red: 255, green: 0, blue: 0)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColorView()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateSelfViewSize()
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.dismissOverlay()
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.dismissOverlay()
    }

    // [Slider]
    
    @IBAction func blueColorSliderChanged(_ sender: UISlider) {
        colorCode.blue = Int(sender.value)
        changeColorView()
    }
    
    @IBAction func greenColorSliderChanged(_ sender: UISlider) {
        colorCode.green = Int(sender.value)
        changeColorView()
    }
    
    @IBAction func redColorSliderChanged(_ sender: UISlider) {
        colorCode.red = Int(sender.value)
        changeColorView()
    }
}

// MARK: - Public Methods

extension DispEditColorViewController {
    func updateColorCode(colorCode: RGBColorCode) {
        self.colorCode.red = colorCode.red
        self.colorCode.green = colorCode.green
        self.colorCode.blue = colorCode.blue
//        changeColorView()
    }
}

// MARK: - Private Methods

extension DispEditColorViewController {
    private func updateSelfViewSize() {
        // 整體外觀
        preferredContentSize = CGSize(width: CGFloat(512), height: CGFloat(360))
    }
    
    private func updateUI() {
        cancelButtonView.setTitle(str_dispEditColor_cancel, for: .normal)
        finishButtonView.setTitle(str_dispEditColor_finish, for: .normal)
        
        colorTitle.text = str_dispEditColor_colorTitle
        
        colorView.layer.cornerRadius = 5
        colorView.clipsToBounds = true
        
        redColorSlider.value = Float(colorCode.red)
        greenColorSlider.value = Float(colorCode.green)
        blueColorSlider.value = Float(colorCode.blue)
    }
    
    private func changeColorView(){

        colorView.backgroundColor = UIColor(
            red: CGFloat(colorCode.red) / 255,
            green: CGFloat(colorCode.green) / 255,
            blue: CGFloat(colorCode.blue) / 255,
            alpha: 1
        )
    }
}
