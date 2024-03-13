import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // IBOutlet variables to display progress and title
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Dictionary containing cooking times for different egg hardness
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    // Timer object to update progress
    var timer = Timer()
    
    // AVAudioPlayer object to play sound
    var player: AVAudioPlayer!
    
    // Variable to store total cooking time
    var totalTime = 0
    
    // Variable to store seconds passed
    var secondsPassed = 0
    
    // IBAction function triggered by button press
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // Invalidate any existing timer
        timer.invalidate()
        
        // Get the selected egg hardness
        let hardness = sender.currentTitle!
        
        // Set total cooking time based on selected hardness
        totalTime = eggTimes[hardness]!

        // Reset progress bar and seconds passed
        progressBar.progress = 0.0
        secondsPassed = 0
        
        // Set the title label to display selected hardness
        titleLabel.text = hardness

        // Start a timer to update progress and play sound
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    // Function to update progress and play sound
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            // Update progress bar
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            // If cooking time is over, stop the timer, display "DONE!" and play sound
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            // Play sound
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
