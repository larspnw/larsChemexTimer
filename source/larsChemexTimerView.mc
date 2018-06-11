//
// larsWare - chemex timer

//	•	Water phases: 
//	•	To 100g for 45s 
//	•	To 250g for 60s 
//	•	To 350g for 2min 

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.Attention as Attention;
using Toybox.Test as Test;

var timer1;
var dataColor = "";
var vibrateData = [ new Attention.VibeProfile( 50, 2000) ];
             
enum
    {
        POUR100,
        POUR250,
        POUR350,
        STEEP,
        DRINK
    }

var mTimerState = null;
var sTimerState = "";	//initial

//added 5sec for pour to each
var limitPour100 = 50;
var limitPour250 = 65;
var limitPour350 = 125;
var limitPour = 10;

var count = limitPour100; //initial

class larsChemexTimerView extends Ui.View {

    function initialize() {
        Ui.View.initialize();
    }

    function callback1() {
        count -= 1;
        
        //Transitions
        if ( mTimerState == POUR100 && count == 0 ) {
        	mTimerState = POUR250;
        	count = limitPour250;
        	Attention.vibrate(vibrateData);
        } else if ( mTimerState == POUR250 && count == 0 ) {
        	mTimerState = POUR350;
        	count = limitPour350; 
        	Attention.vibrate(vibrateData);
        } else if ( mTimerState == POUR350 && count == 0 ) {
        	mTimerState = DRINK;
        	count = 0;
        	Attention.vibrate(vibrateData);
        	timer1.stop();
        }
        
        Ui.requestUpdate();
    }

	function startTimer() {
        timer1 = new Timer.Timer();
        timer1.start(method(:callback1), 1000, true);
        
        mTimerState = POUR100;
        
        Attention.vibrate(vibrateData);
    }

    function onLayout(dc) {
    }

    function onUpdate(dc) {
    
    	var string;
    	
   		//! Select text color based on timer state.
        if( mTimerState == POUR100 )
        {
             dataColor = Gfx.COLOR_RED;
             sTimerState = "Pour to 100g";
        }
        else if( mTimerState == POUR250 )
        {
        	dataColor = Gfx.COLOR_ORANGE;
        	sTimerState = "Pour to 250g";
        }
        else if( mTimerState == POUR350 )
        {
            dataColor = Gfx.COLOR_YELLOW;
            sTimerState = "Pour to 350g";
        }
        else if (mTimerState == DRINK )
        {
           dataColor = Gfx.COLOR_GREEN;
           sTimerState = "DRINK";
        } 
        else if (mTimerState == null) 
        {
        	dataColor = Gfx.COLOR_WHITE;
        	sTimerState = "Press start";
        }

        //dc.setColor(dataColor, Gfx.COLOR_WHITE);
        //dc.clear();
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        dc.setColor(dataColor, Gfx.COLOR_TRANSPARENT);
        string = "Phase: " + sTimerState;
        dc.drawText(5, (dc.getHeight() / 2) - 30, Gfx.FONT_MEDIUM, string, Gfx.TEXT_JUSTIFY_LEFT);
        string = "Time Left: " + formatTime(count);
       	dc.drawText(5, (dc.getHeight() / 2), Gfx.FONT_MEDIUM, string, Gfx.TEXT_JUSTIFY_LEFT);
       // string = "Count: " + count3;
       // dc.drawText(40, (dc.getHeight() / 2) + 30, Gfx.FONT_MEDIUM, string, Gfx.TEXT_JUSTIFY_LEFT);
    }

	function formatTime(iTime) {
	
		if ( iTime < 60 ) {
			return iTime;
		}
			
		var iMin = iTime / 60;
		var iSec = iTime % 60;
		
		if (iSec < 10 ) { 
			iSec = "0" + iSec;
		}
		return iMin + ":" + iSec;	
	}
	
	
}

class testLarsChemexTimer {
//TESTS
	(:test)
	function testFormatTime(logger) {
		//Test.assert(true);
		
		//Test.assertEqual(larsChemexTimer.formatTime(0), "0");
		
		var x = larsChemexTimerView.formatTime(59);
		System.println("x: " + x);
		Test.assert(x+"" == "59");
		//Test.assertEqual(formatTime(61),"1:01");
		//Test.assertEqual(formatTime(132),"2:12");
		
		return true;
	}
}
