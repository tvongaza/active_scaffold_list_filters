/*/
 
	Filter Accordion 1.0
	
	By: Sean Healy, www.odil.ca
	Copyright (c) 2008 Orange Door Idealab Inc.
	
	Accordion Filter is freaccordiony distributable under the terms of an MIT-style license.
	
/*/ 



function init_filter_accordions()
{
	$$('.filter_accordion').each(function(accordion)
	{
		if(accordion.initialized)
			return true;
		
		var handles = accordion.select('.filter_handle');
		var bodies = accordion.select('.filter_body');
		
		if(handles.length != bodies.length)
			return false;
		
		accordion.number_of_panes = handles.length;
		
		for(var i = 0; i < handles.length; i++)
		{
			var handle = handles[i];
			var body = bodies[i];
			
			body.setStyle({display: 'none'});
			
			handle.body = body;
			
			if(Prototype.Browser.IE)
				var canvas = excanvas(handle.select('canvas')[0]);
			else
				var canvas = handle.select('canvas')[0];
			
			drawFilterLabelText(canvas, handle.title);
			
			handle.observe('click', function(event)
			{
				var current = Event.element(event)
			
				while(!current.hasClassName('filter_handle'))
				{
					current = current.parentNode;
				}
				
				current.parentNode.active.removeClassName('active');
				current.addClassName('active');
				
				current.parentNode.active.body.removeClassName('active');
				current.body.addClassName('active');
				
				current.parentNode.active.body.setStyle({display: 'none'});
				current.body.setStyle({display: 'block'});
				
				current.parentNode.active = current;
			});
		}
		
		accordion.active = handles[0];
		accordion.active.body.setStyle({display: 'block'});
		accordion.active.body.addClassName('active');
		accordion.active.addClassName('active');
		accordion.initialized = true;
	});
}

/*
Notes:

current.body.setStyle({width: (current.parentNode.getWidth()-(current.parentNode.number_of_panes*23) - 2)+'px'});
*/
