//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// Displays a weekly weather details.
final class WeeklyDetailsView: UIView {
    // MARK: - Outlets
    @IBOutlet private var contentView: UIView!
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
    private let viewModel: WeeklyDetailsViewModel = WeeklyDetailsViewModel(apiManager: WeatherApiManager.shared)

    /// Returns item number.
    private var itemNumber: Int {
        return viewModel.filteredList.count
    }

    // MARK: - Private Enums
    private enum Constants {
        static let cellHeight: CGFloat = 90.0
        static let titleRadius: CGFloat = 9.0
        static let nibName: String = "WeeklyDetailsView"
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
    func commonInitWeeklyDetailsView() {
        Bundle.main.loadNibNamed(Constants.nibName, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear

        let nib = UINib(nibName: "WeeklyDetailsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "WeeklyDetailsCollectionViewCell")

        weeklyTitleLabel.text = L10n.weeklyDetails
        weeklyTitleView.cornerRadiusedWith(backgroundColor: .white20,
                                           radius: Constants.titleRadius)
        setupViewModel()
    }

    func setupViewModel() {
        viewModel.weeklyDetailsModelObs.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WeeklyDetailsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemNumber
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeeklyDetailsCollectionViewCell",
                                                      for: indexPath)

        if let weeklyCell = cell as? WeeklyDetailsCollectionViewCell {
            let weatherDay = viewModel.filteredList[indexPath.row]
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
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / (CGFloat(itemNumber) + 1.0)
        let height: CGFloat = Constants.cellHeight

        return CGSize(width: width, height: height)
    }
}
