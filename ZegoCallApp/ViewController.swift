//
//  ViewController.swift
//  ZegoCallApp
//
//  Created by Talal El Zeini on 11/28/25.
//

import UIKit
import ZegoUIKitPrebuiltCall

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userID: String = String(format: "%d", Int.random(in: 0...99999))
    var userName: String?
    let yourAppID: UInt32 = 0
    let yourAppSign: String = ""

    var sessions: [String] = ["100", "200", "300", "400", "500"]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        userName = "user_\(userID)"

        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let id = sessions[indexPath.row]

        cell.textLabel?.text = "Session ID: \(id)"
        cell.detailTextLabel?.text = "Tap to join"
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let callID = sessions[indexPath.row]
        makeNewCall(sessionID: callID)
    }

    @IBAction func makeNewCall(sessionID: String) {

        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
        let config: ZegoUIKitPrebuiltCallConfig = ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()

        let callVC = ZegoUIKitPrebuiltCallVC.init(yourAppID,
                                                  appSign: yourAppSign,
                                                  userID: userID,
                                                  userName: userName ?? "",
                                                  callID: sessionID,
                                                  config: config)
        callVC.modalPresentationStyle = .fullScreen
        self.present(callVC, animated: true, completion: nil)
    }


}
