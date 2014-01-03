#tag Class
Protected Class JSONRPC
Inherits JSONRPCSocket
	#tag Event
		Sub Connected()
		  WindowMain.ListboxMessages.AddRow ""
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error()
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ResponseReceived(Response As JSONItem, IsError As Boolean)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub SendComplete(userAborted as Boolean)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function SendProgress(bytesSent as Integer, bytesLeft as Integer) As Boolean
		  
		End Function
	#tag EndEvent


	#tag Note, Name = This is the server part
		
		This socket acts as if it was a server. 
		
		For the example you can open 2 of these programs.
		One selected as server and the other as client, wich makes requests to the other.
	#tag EndNote


End Class
#tag EndClass
