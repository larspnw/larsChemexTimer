//
// larsWare
//

using Toybox.WatchUi as Ui;

class InputDelegate extends Ui.BehaviorDelegate {

	var mParentView;
	
    function initialize(view) {
        Ui.BehaviorDelegate.initialize();
        mParentView = view;
    }

    function onMenu() {
        timer1.stop();
        return true;
    }
    
    function onSelect() {
     	mParentView.startTimer();
        return true;
    }
}