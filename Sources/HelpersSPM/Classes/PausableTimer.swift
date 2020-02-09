import Foundation

public class PausableTimer {
	private var timerDuration: Double
	private var timerFiredCompletion: () -> Void
	
	private var timer: Timer
	private var startDate: Date?
	private var timeElapsed: Double
	
	public init(timerDuration: Double, timerFiredCompletion: @escaping () -> Void) {
		self.timerDuration = timerDuration
		self.timerFiredCompletion = timerFiredCompletion
		timer = Timer()
		timeElapsed = 0.0
	}
	
	func start() -> PausableTimer {
		timer = Timer.scheduledTimer(timeInterval: self.timerDuration - timeElapsed,
									 target: self,
									 selector: #selector(timerFired),
									 userInfo: nil,
									 repeats: false)
		startDate = Date()
		return self
	}
	
	func pause() {
		guard let startDate = startDate else {
			print("⚠️ Can't pause timer, it hasn't been started.")
			return
		}
		
		timer.invalidate()
		timeElapsed = Date().timeIntervalSince(startDate)
	}
	
	func resume() {
		_ = start()
	}
	
	func stop() {
		timer.invalidate()
	}
	
	@objc
	private func timerFired() {
		timer.invalidate()
		timerFiredCompletion()
	}
}
