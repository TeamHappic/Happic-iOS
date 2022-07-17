//
//  HappicReportController.swift
//  Happic-iOS
//
//  Created by sejin on 2022/07/08.
//

import UIKit
import SnapKit
import Then

final class HappicReportController: UIViewController {
    
    // MARK: - UI
    private let customMonthView = CustomMonthView()
    private let customMonthPickerView = CustomMonthPickerView()
    private let reportScrollView = UIScrollView()
    private let contentView = UIView()
    private let bestHappicMomentView = BestHappicMomentView()
    private let keywordRankView = KeywordRankView()
    private let categoryRankView = CategoryRankView()
    private let monthHappicRecordView = MonthHappicRecordView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPurpleBackgroundColor()
        configureUI()
        setDelegate()
    }
    
    // MARK: - Functions
    private func configureUI() {
        view.addSubviews(customMonthView, customMonthPickerView)
        customMonthView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(65)
        }
        
        customMonthPickerView.snp.makeConstraints { make in
            make.top.equalTo(customMonthView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(230)
        }
        
        customMonthPickerView.isHidden = true
        
        setScrollViewLayout()
        setSubViewsLayout()
    }
    
    private func setDelegate() {
        customMonthView.delegate = self
        customMonthPickerView.delegate = self
        keywordRankView.headerView.delegate = self
        categoryRankView.headerView.delegate = self
        monthHappicRecordView.headerView.delegate = self
    }
    
    private func setScrollViewLayout() {
        view.addSubviews(reportScrollView)
        reportScrollView.snp.makeConstraints { make in
            make.top.equalTo(customMonthView.snp.bottom)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        reportScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(reportScrollView.contentLayoutGuide)
            make.width.equalTo(reportScrollView.snp.width)
            make.height.greaterThanOrEqualTo(reportScrollView.snp.height).priority(500)
        }
    }
    
    private func setSubViewsLayout() {
        contentView.addSubviews(bestHappicMomentView, keywordRankView, categoryRankView, monthHappicRecordView)
        bestHappicMomentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(292)
        }
        
        keywordRankView.snp.makeConstraints { make in
            make.top.equalTo(bestHappicMomentView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(374)
        }
        
        categoryRankView.snp.makeConstraints { make in
            make.top.equalTo(keywordRankView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(555)
        }
        
        monthHappicRecordView.snp.makeConstraints { make in
            make.top.equalTo(categoryRankView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(313)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}

// MARK: - Extensions

extension HappicReportController: HappicReportSectionHeaderDelegate {
    func showOverallStatsController(type: HappicReportSectionType) {
        let overallStatsController = OverallStatsController()
        overallStatsController.selectedIndex = type.rawValue
        self.navigationController?.pushViewController(overallStatsController, animated: true)
    }
}

extension HappicReportController: CustomMonthViewDelegate {
    func setMonthPickerView(_ isMonthViewEnabled: Bool) {
        if isMonthViewEnabled {
            self.view.bringSubviewToFront(customMonthPickerView)
            customMonthPickerView.isHidden = false
        } else {
            customMonthPickerView.isHidden = true
        }
    }
}

extension HappicReportController: CustomMonthPickerViewDelegate {
    func changeMonthStatus(_ month: String) {
        if month.count == 1 {
            customMonthView.monthLabel.text = "2022 . 0\(month)"
        } else {
            customMonthView.monthLabel.text = "2022 . \(month)"
        }
    }
}
