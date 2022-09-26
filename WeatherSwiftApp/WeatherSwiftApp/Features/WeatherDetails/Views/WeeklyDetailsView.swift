//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import Reusable
import RxSwift
import WeatherSwiftSDK

/// Displays a weekly weather details.
final class WeeklyDetailsView: UIView, NibOwnerLoadable {
    // MARK: - Outlets
    @IBOutlet private weak var weeklyTitleView: UIView!
    @IBOutlet private weak var weeklyTitleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Internal Properties
    var cityName: String? {
        didSet {
            guard let city = cityName else { return }

            viewModel.requestWeather(city: city)
        }
    }

    // MARK: - Private Properties
    private let viewModel: WeeklyDetailsViewModel = WeeklyDetailsViewModel()
    private let disposeBag = DisposeBag()

    /// Returns filtered list with only daily value (hourly value are skipped).
    private var filteredList: [DailyWeather] {
        var filteredTab: [DailyWeather] = []
        if let list = try? viewModel.dailyDetailsModel.value().list {
            list.forEach { element in
                let formatter = DateFormatter()
                formatter.dateFormat = Constants.format
                guard let dateHour = Int(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(element.date)))) else { return }

                if Constants.afternoonTab.contains(dateHour) {
                    filteredTab.append(element)
                }
            }
        }

        return filteredTab
    }

    /// Returns item number.
    private var itemNumber: Int {
        return filteredList.count
    }

    // MARK: - Private Enums
    private enum Constants {
        static let cellHeight: CGFloat = 90.0
        static let titleRadius: CGFloat = 9.0
        static let format: String = "HH"
        static let afternoonTab: [Int] = [13, 14, 15]
    }

    // MARK: - Override Funcs
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitWeeklyDetailsView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitWeeklyDetailsView()
    }
}

// MARK: - Private Funcs
private extension WeeklyDetailsView {
    /// Common init.
    func commonInitWeeklyDetailsView() {
        self.loadNibContent()
        setupViewModel()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: WeeklyDetailsCollectionViewCell.self)
        weeklyTitleLabel.text = L10n.weeklyDetails
        weeklyTitleView.cornerRadiusedWith(backgroundColor: .white20,
                                           radius: Constants.titleRadius)
    }

    /// Sets up observer for weekly view model.
    func setupViewModel() {
        viewModel.dailyDetailsModel.subscribe { [weak self] _ in
            self?.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDataSource
extension WeeklyDetailsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemNumber
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyDetailsCollectionViewCell.reuseIdentifier, for: indexPath)

        if let weeklyCell = cell as? WeeklyDetailsCollectionViewCell {
            let weatherDay = filteredList[indexPath.row]
            weeklyCell.setupCell(date: weatherDay.date,
                                 icon: UIImage(named: weatherDay.weather[0].icon),
                                 temperature: Int(weatherDay.main.temp))
            return cell
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WeeklyDetailsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / (CGFloat(itemNumber) + 1.0)
        let height: CGFloat = Constants.cellHeight

        return CGSize(width: width, height: height)
    }
}
