//
//  ViewController.swift
//  LearnAutoLayout
//
//  Created by QDSG on 2019/3/18.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

let margin: Float = 10
let redLabelString = "T AO"
let blueLabelString = "https://github.com/Germtao"
let subLeftString = "iOS 开发"
let subRightString = "吃鸡王者"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        
        setupUI()
        setupUIContraints()
    }
    
    // MARK: - Set UI
    private func setupUI() {
        view.addSubview(contentView)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(describeLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(subHelperView)
        subHelperView.addSubview(subLeftLabel)
        subHelperView.addSubview(subSeparateView)
        subHelperView.addSubview(subRightLabel)
        
        view.addSubview(adjustSlider)
    }
    
    private func setupUIContraints() {
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(60)
            make.left.equalTo(view).offset(margin)
            make.right.equalTo(view).offset(-margin)
            make.height.equalTo(90)
        }
        
        avatarImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(margin)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(margin)
            make.top.equalTo(avatarImageView).offset(margin)
        }
        
        describeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(margin)
            make.top.equalTo(nameLabel)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(describeLabel.snp.right).offset(margin)
            make.top.equalTo(nameLabel)
            make.size.equalTo(CGSize(width: 30, height: 20))
            make.right.lessThanOrEqualTo(contentView).offset(-margin)
        }
        
        subHelperView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(margin)
            make.left.equalTo(nameLabel)
            make.right.equalTo(contentView).offset(-margin)
        }
        
        subLeftLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(subHelperView)
            make.width.greaterThanOrEqualTo(100)
        }
        
        subSeparateView.snp.makeConstraints { (make) in
            make.top.equalTo(subLeftLabel).offset(6)
            make.left.equalTo(subLeftLabel.snp.right).offset(margin)
            make.size.equalTo(CGSize(width: 15, height: 2))
        }
        
        subRightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subLeftLabel)
            make.left.equalTo(subSeparateView.snp.right).offset(margin)
            make.width.greaterThanOrEqualTo(100)
            make.right.lessThanOrEqualTo(subHelperView).offset(-margin)
        }
        
        adjustSlider.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.bottom).offset(margin)
            make.left.equalTo(view).offset(margin)
            make.right.equalTo(view).offset(-margin)
        }
    }
    
    // MARK: - Lazy Load
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowColor = UIColor(white: 0.00, alpha: 100).cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 4
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 35 / 2
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.orange
        label.text = redLabelString
        
        // 使用 Auto Layout 一定要注意多使用 CompreResistance Priority 和 Hugging Priority
        // 利用优先级的设置, 让布局更加灵活, 代码更少, 更易于维护
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return label
    }()
    
    lazy var describeLabel: UILabel = {
        let label = UILabel()
        label.text = blueLabelString
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        imageView.image = UIImage(named: "starmingicon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var adjustSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = margin
        slider.maximumValue = 200
        slider.minimumTrackTintColor = UIColor.lightGray
        slider.addTarget(self, action: #selector(updateAdjustSliderValue(_:)), for: .valueChanged)
        return slider
    }()
    
    lazy var subHelperView = UIView()
    
    lazy var subLeftLabel: UILabel = {
        let label = UILabel()
        label.text = subLeftString
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    lazy var subSeparateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return view
    }()
    
    lazy var subRightLabel: UILabel = {
        let label = UILabel()
        label.text = subRightString
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return label
    }()
}

extension ViewController {
    @objc private func updateAdjustSliderValue(_ slider: UISlider) {
        let f = slider.value
        self.contentView.snp.updateConstraints { (make) in
            make.left.equalTo(self.view).offset(f)
        }
    }
}
