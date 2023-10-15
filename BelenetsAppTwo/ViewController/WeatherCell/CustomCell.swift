//
//  CustomCell.swift
//  BelenetsAppTwo
//
//  Created by Alena Belenets on 09.10.2023.
//

import Foundation
import UIKit

// MARK: - CustomCell
final class CustomCell: UITableViewCell {

    // MARK: - Properties
    static var identifier: String {
        return String(describing: self)
    }

    var data: List? {
        didSet {
            if let weatherData = data {
                let date = Helpers.shared.getCurrentDate(weatherData.dt)
                let temperature = String(format: "%.1f", weatherData.main.temp)

                dateLabel.text = date
                tempLabel.text = "\(temperature)°"

            }
        }
    }

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.text = "Error"

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.text = "Error"

        return label
    }()

    // MARK: - Functions
    override func prepareForReuse() {
        super.prepareForReuse()
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - extension CustomCell
extension CustomCell {
    func setUp() {
        addViews()
        makeConstraints()

    }
    func addViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(tempLabel)
    }

    func makeConstraints() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            tempLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Numbers.twelve.rawValue),
            tempLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

            dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Numbers.twelve.rawValue),
            dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)

        ])

    }
}
