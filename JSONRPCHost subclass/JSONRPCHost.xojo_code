#tag Class
Protected Class JSONRPCHost
Inherits JSONRPCSocket
	#tag Event
		Sub Connected()
		  WindowMain.Title = WindowMain.WINDOW_TITLE + " - Socket Connected"
		End Sub
	#tag EndEvent

	#tag Event
		Sub RequestReceived(Request As JSONItem, IsNotification As Boolean)
		  'Error handling should be done here. JSONException is already tested for.
		  
		  
		  if IsNotification then
		    'has no ID value, LastID should not be used
		    WindowMain.ListboxMessages.AddRow "Notification", Request.Value("params").StringValue, Request.ToString
		  else
		    '
		    WindowMain.ListboxMessages.AddRow Str(me.LastID), Request.Child("params").ToString, Request.ToString
		  end if
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ResponseReceived(Response As JSONItem, IsError As Boolean)
		  'Only to be used as client
		  
		End Sub
	#tag EndEvent


	#tag Note, Name = This is the server part
		
		This socket acts as if it was a server. 
		
		For the example you can open 2 of these programs.
		One selected as server and the other as client, wich makes requests to the other.
	#tag EndNote


End Class
#tag EndClass
