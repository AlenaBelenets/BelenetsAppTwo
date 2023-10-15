//
//  ViewController.swift
//  BelenetsAppTwo
//
//  Created by Alena Belenets on 08.10.2023.
//

import UIKit


// MARK: - UIViewController
class ViewController: UIViewController {

    // MARK: - Private Properties

    private var dataSource = [List]()

    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.fetchWeather {
                self.tableView.reloadData()
            }
        }
    }

    private let townLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "Error"

        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        label.textColor = .white
        label.text = "Error"

        return label
    }()

    private var tableView: UITableView = {
        let table = UITableView()
        table.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        table.allowsSelection = true
        table.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

        return table
    }()

    private var searchTextField: UITextField = {
        let textField = UITextField()

        textField.placeholder = "Search"
        textField.layer.borderWidth = Numbers.two.rawValue
        textField.backgroundColor = .white
        textField.layer.cornerRadius = Numbers.twelve.rawValue
        textField.layer.borderColor = CGColor(red: Numbers.forty.rawValue, green: Numbers.thirty.rawValue, blue: Numbers.twentyFive.rawValue, alpha: Numbers.one.rawValue)

        return textField
    }()

    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        viewModel = ViewModel()

        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
        setupLabels()
        setupTextField()

        searchTextField.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupUI()
    }

// MARK: - Setup UI
    private func setupUI() {

        viewModel.fetchWeather { [weak self] in
            self?.townLabel.text = self?.viewModel.cityName
            self?.temperatureLabel.text = self?.viewModel.temp
            self?.dataSource = (self?.viewModel.dataSource)!
            self?.tableView.reloadData()

        }
    }
    private func setupTextField() {
        searchTextField.frame = CGRect(x: Numbers.threeHundred.rawValue, y: Numbers.seventy.rawValue, width: Numbers.oneHundredAndFifty.rawValue, height: Numbers.fifty.rawValue)
        searchTextField.center.x = CGFloat(self.view.bounds.midX)
        self.view.addSubview(searchTextField)

    }
    private func setupTableView() {
        self.view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        self.view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.separatorColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

    private func setupLabels() {
        self.view.addSubview(townLabel)
        self.view.addSubview(temperatureLabel)
        townLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            townLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            townLabel.bottomAnchor.constraint(equalTo: self.tableView.topAnchor),
            townLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 1),

            temperatureLabel.topAnchor.constraint(equalTo: self.townLabel.bottomAnchor, constant: -100),
            temperatureLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 1)

        ])

    }
}




// MARK: - Extension UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { return UITableViewCell() }

        let data = viewModel.dataSource[indexPath.row]
        cell.data = data

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Numbers.seventy.rawValue
    }

}


// MARK: - Extension UITextFieldDelegate
extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        searchTextField.text = ""
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let town = searchTextField.text {
            viewModel.fetchTown(townName: town)
        }

        searchTextField.text = ""
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter the city"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                textField.placeholder = "Search"
            }
            return false
        }
    }

}

