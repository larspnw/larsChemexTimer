//
// larsWare
//

using Toybox.Application as App;

class larsChemexTimerApp extends App.AppBase {

    function initialize() {
        App.AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	var mView = new larsChemexTimerView();
        return [ mView, new InputDelegate(mView) ];
    }

}
