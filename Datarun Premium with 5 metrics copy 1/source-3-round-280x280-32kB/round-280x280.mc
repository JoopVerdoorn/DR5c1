using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

//! inherit from the view that contains the commonlogic
class DeviceView extends PowerView {
	var myTime;
	var strTime;

	//! it's good practice to always have an initialize, make sure to call your parent class here!
    function initialize() {
        PowerView.initialize();
    }

	function onUpdate(dc) {
		//! call the parent function in order to execute the logic of the parent
		PowerView.onUpdate(dc);

		//! Draw separator lines
        dc.setColor(mColourLine, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);

        //! Horizontal thirds
        dc.drawLine(47,  33,  233, 33);
        dc.drawLine(0,   108,  280, 108);
        dc.drawLine(0,   204, 280, 204);

        //! Top vertical divider
        dc.drawLine(139, 34,  139, 107);

        //! Centre vertical dividers
        dc.drawLine(139,  107,  139,  204);
        
        //! Bottom horizontal divider
		dc.drawLine(62, 256, 218, 256); 
	
		//! Show clock with current time in top
		dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);
		myTime = Toybox.System.getClockTime(); 
    	strTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d");
		dc.drawText(140, -3, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);

		//! Display metrics
		for (var i = 1; i < 6; ++i) {
	    	if ( i == 1 ) {			//!upper row, left
				Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"081,081,085,017,089,085,043");
			} else if ( i == 2 ) {	//!upper row, right
				Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"198,081,210,142,089,195,043");
	       	} else if ( i == 3 ) {  //!lower row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"072,167,084,014,169,085,118");
	       	} else if ( i == 4 ) {	//!lower row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"202,167,212,144,195,195,118");
	       	} else if ( i == 5 ) {  //!middle row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"175,228,192,130,235,080,242");
	       	}     	
		}
		
//!		if (jTimertime == 0) {
//!	    	if (ID0 != 3624 and ID0 != 3588 and ID0 != 3762 and ID0 != 3761 and ID0 != 3757 and ID0 != 3758 and ID0 != 3759) {
//!		    	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
//!				dc.drawText(120, 160, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);
//!		    }
//!		}
		
		//! Bottom battery indicator
	 	var stats = Sys.getSystemStats();
		var pwr = stats.battery;
		var mBattcolor = (pwr > 15) ? mColourFont : Graphics.COLOR_RED;
		dc.setColor(mBattcolor, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(107, 259, 63, 18);
		dc.fillRectangle(170, 264, 4, 8);
	
		dc.setColor(mColourBackGround, Graphics.COLOR_TRANSPARENT);
		var Startstatuspwrbr = 110 + Math.round(pwr*0.58)  ;
		var Endstatuspwrbr = 58 - Math.round(pwr*0.58) ;
		dc.fillRectangle(Startstatuspwrbr, 261, Endstatuspwrbr, 14);		
	   
	}

}