import UIKit
import MediaPlayer

class SideMenu: UIViewController, UITableViewDelegate, UITableViewDataSource, MPMediaPickerControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cell"
    let titles = ["Add Music",
                    "Add Beats",
                    "Studio",
                    "Share",
                    "Settings"]
    var musicChosen: Bool = false
    let songBubbleSize: CGFloat = UIScreen.main.bounds.width / 15

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = self.titles[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.titles[indexPath.row] {
        case "Add Music":
            self.addMusic()
            break
        case "Add Beats":
            print("Add Beats")
            break
        case "Studio":
            print("Studio")
            break
        case "Share":
            print("Share")
            break
        case "Settings":
            print("Settings")
            break
        default:
            print("You shouldn't be here.")
        }
    }

    func addMusic() {
        let songPicker = MPMediaPickerController(mediaTypes: .music)
        songPicker.allowsPickingMultipleItems = false
        songPicker.popoverPresentationController?.sourceView = self.view
        songPicker.delegate = self
        self.present(songPicker, animated: true, completion: nil)
    }

    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        if (musicChosen) {
            MainViewController.musicNode.songPlayer.setQueue(with: mediaItemCollection)
            MainViewController.musicNode.songPlayer.play()
        } else {
            let newBubble = self.addBubble()
            newBubble.songPlayer.setQueue(with: mediaItemCollection)
            newBubble.songPlayer.play()
            self.musicChosen = true
        }
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }

    func addBubble() -> SongBubble {
        let beatNode = UIImage(color: .red, size: CGSize(width: self.songBubbleSize, height: self.songBubbleSize))
        let beatNodeView = SongBubble(image: beatNode)

        let origin = CGPoint(x: UIScreen.main.bounds.width / 2 - songBubbleSize, y: UIScreen.main.bounds.height / 2 - songBubbleSize)
        beatNodeView.frame = CGRect(origin: origin, size: beatNode.size)
        beatNodeView.layer.cornerRadius = 10.0
        beatNodeView.layer.masksToBounds = true
        beatNodeView.isUserInteractionEnabled = true

        MainViewController.v.addSubview(beatNodeView)
        MainViewController.musicNode = beatNodeView
        return beatNodeView
    }
}
