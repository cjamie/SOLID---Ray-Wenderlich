
import UIKit

class MultipleResponsibilityViewController: UIViewController {
    let data = ["Dog", "Cat", "Octopus", "Skunk", "Squirrel"]
    let imageNames = ["dog", "cat", "octopus", "skunk", "squirrel"]
    private var selectedIndex: IndexPath!

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let viewController = segue.destination as? AnimalDetailsViewController {
            viewController.animal = data[selectedIndex.row]
            viewController.image = UIImage(named: imageNames[selectedIndex.row])
        }
    }
}

extension MultipleResponsibilityViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animal") ?? UITableViewCell(style: .default, reuseIdentifier: "data")
        cell.textLabel?.text = data[indexPath.row]
        cell.imageView?.image = UIImage(named: imageNames[indexPath.row])
        return cell
    }
}

extension MultipleResponsibilityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        performSegue(withIdentifier: "showAnimal", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MultipleResponsibilityViewController: UINavigationControllerDelegate {
    func navigationController(_: UINavigationController,
                              animationControllerFor _: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC == self, toVC is AnimalDetailsViewController {
            return self
        }
        return nil
    }
}

extension MultipleResponsibilityViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.containerView.backgroundColor = .white

        guard let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from),
            let fromViewController = transitionContext.viewController(forKey: .from) as? MultipleResponsibilityViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? AnimalDetailsViewController,
            let selectedCell = fromViewController.tableView.cellForRow(at: selectedIndex) else {
            transitionContext.completeTransition(false)
            return
        }

        transitionContext.containerView.addSubview(fromView)
        transitionContext.containerView.addSubview(toView)

        let imageCopy = UIImageView(image: selectedCell.imageView!.image)
        transitionContext.containerView.addSubview(imageCopy)
        imageCopy.frame = selectedCell.convert(selectedCell.imageView!.frame, to: nil)

        toView.alpha = 0
        toViewController.view.layoutSubviews()
        toViewController.imageView.alpha = 0

        UIView.animate(withDuration: 0.2, animations: {
            imageCopy.frame = toViewController.view.convert(toViewController.imageView.frame, to: nil)
            toView.alpha = 1
        }, completion: { complete in
            imageCopy.removeFromSuperview()
            toViewController.imageView.alpha = 1
            transitionContext.completeTransition(complete)
    })
    }
}

class AnimalDetailsViewController: UIViewController {
    var animal: String!
    var image: UIImage!

    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = animal

        imageView.image = image
    }
}
