
import UIKit

class SingleResponsibilityViewController: UIViewController {
    private let tableView = UITableView()
    private weak var adapter: TableDataAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutTable()
        setTableData()
    }
    
    // MARK: - Helpers
    
    private func layoutTable() {
        view.addSubview(tableView)
                
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    
        ])
        
    }
    
    private func setTableData() {
        let data = ["Dog", "Cat", "Peacock", "Goat", "Raccoon"]
        let adapter = TableDataAdapter(data: data) { animal in
            print("Your preferred animal is \(animal)")
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "data")
        tableView.dataSource = adapter
        tableView.delegate = adapter
    }
    
}

private class TableDataAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let onClick: (String) -> Void
    private let data: [String]
    
    init(data: [String], onClick: @escaping (String) -> Void) {
        self.onClick = onClick
        self.data = data
    }
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "data") ?? UITableViewCell(style: .default, reuseIdentifier: "data")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        onClick(data[indexPath.row])
    }
}
