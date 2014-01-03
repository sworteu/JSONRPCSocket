#tag Class
Protected Class JSONRPCSocket
Inherits TCPSocket
	#tag Event
		Sub DataAvailable()
		  'JSON-RPC response received.
		  Dim buff, Messages(), CurrentMessage As String
		  Dim MessageCount As Integer 
		  
		  buff = me.ReadAll(Encodings.UTF8)
		  
		  if me.Debug then
		    System.DebugLog( "DATA:" )
		    System.DebugLog( buff )
		  end if
		  
		  'We need to know how many JSON messages are send. It might be a Batch Call:
		  'http://www.jsonrpc.org/specification#batch
		  MessageCount = Buff.InStr("},{")
		  
		  if MessageCount > 0 then
		    'It's a Batch Call
		    Messages() = Buff.Split("},{") 
		    For each Message As String in Messages()
		      
		      if Message.Right(0) <> "}" then
		        Message = Message + "}" 'Put back the closing bracket
		      end if
		      
		      if Message.Left(0) <> "{" then
		        'Put back the start bracket
		        Message = "{" + Message
		      end if
		      
		      'Try to handle the message
		      HandleMessage( Message )
		      
		    Next
		  else
		    
		    HandleMessage (buff)
		    
		  end if
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub HandleMessage(Message As String)
		  Dim Response As JSONItem
		  Dim iNotification As Boolean
		  
		  
		  Try
		    'To be sure we catch any exception
		    Response = new JSONItem
		    Response.Load( Message )
		    
		    if Response.HasName("id") then
		       iNotification = False
		    else 
		      iNotification = True
		    end if
		    
		    
		    if Response.HasName("error") then
		      'The "error" value is only there when it has an error
		      'We parse the JSONItem, and set the flag IsError in the Response event
		      
		      if me.Debug then
		        System.DebugLog( "JSON-RPC" )
		        System.DebugLog( CurrentMethodName + " >> JSON-RPC Response received" )
		        System.DebugLog( "json-rpc error: " + Response.Child("error").Value("message") )
		        if Response.HasName("id") then
		          System.DebugLog( "json-rpc id: " + Str( Response.Value("id") ) )
		        end if
		      end if
		      
		      RaiseEvent ResponseReceived(Response, True)
		      
		    else
		      'No error, parse the JSONItem
		      
		      if Response.HasName("method") then 
		        'It's a request from a client
		        
		        if me.Debug then
		          System.DebugLog( "JSON-RPC" )
		          System.DebugLog( CurrentMethodName + " >> JSON-RPC Request received" )
		          System.DebugLog( "json-rpc accepted" )
		          if Response.HasName("id") then
		            System.DebugLog( "json-rpc id: " + Str(Response.Value("id") ) )
		          end if
		        end if
		        
		        RaiseEvent RequestReceived(Response, iNotification)
		        
		      else
		        'It's a response from a server
		        
		        if me.Debug then
		          System.DebugLog( "JSON-RPC" )
		          System.DebugLog( CurrentMethodName + " >> JSON-RPC Response received" )
		          System.DebugLog( "json-rpc accepted" )
		          if Response.HasName("id") then
		            System.DebugLog( "json-rpc id: " + Str(Response.Value("id") ) )
		          end if
		        end if
		        
		        RaiseEvent ResponseReceived(Response, False)
		        
		      end if
		      
		    end if
		    
		  Catch e As JSONException
		    'This should not happen.
		    
		    if me.Debug then
		      System.DebugLog( "JSON-RPC" )
		      System.DebugLog( CurrentMethodName + " >> JSONException" )
		      System.DebugLog( Str( e.ErrorNumber ) + " >> " + e.Message )
		      System.DebugLog( "Last id: " + Str(mLastID) )
		    end if
		    
		    RaiseEvent ResponseReceived(nil, True)
		    
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Method(Method As String, Params As JSONItem = nil)
		  'Create a new JSONItem, to be send to the server
		  Dim Req As new JSONItem
		  Dim Encoded As String
		  
		  'If the Method is blank, we stop here.
		  If Method = "" then
		    if me.Debug then
		      System.DebugLog( "JSON-RPC" )
		      System.DebugLog( CurrentMethodName )
		      System.DebugLog( "json-rpc error: No method has been given" )
		      System.DebugLog( "json-rpc info: Method call has been ignored" )
		    end if
		    Return
		  End If
		  
		  'Try to create the JSONItem
		  Try
		    'Create the JSON-RPC data
		    Req.Value("jsonrpc") = "2.0"
		    Req.Value("method") = Method
		    If Params <> nil and Params.IsArray then
		      'Params MUST be an json array object,
		      'It's not required to send Params
		      Req.Value("params") = Params
		    End If
		    Req.Value("id") = (mLastID + 1)
		    
		    'Send the JSONItem (as String with UTF8 encoding) to the server
		    Encoded = ConvertEncoding( Req.ToString, Encodings.UTF8 )
		    me.Write( Encoded )
		    
		    'Set lastID only when everything went right.
		    mLastID = (mLastID + 1)
		    
		    if me.Debug then
		      System.DebugLog( "JSON-RPC" )
		      System.DebugLog( CurrentMethodName )
		      System.DebugLog( "json-rpc accepted" )
		      System.DebugLog( "json-rpc id: " + Str(mLastID) )
		    end if
		    
		  Catch e As JSONException
		    'Exception catched, let's stop moving on and log to system.debuglog
		    
		    if me.Debug then
		      System.DebugLog( "JSON-RPC" )
		      System.DebugLog( CurrentMethodName + " >> JSONException" )
		      System.DebugLog( Str( e.ErrorNumber ) + " >> " + e.Message )
		    end if
		    
		  End Try
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Notification(Method As String, Params As JSONItem = nil)
		  Dim Encoded As String
		  Dim Req As new JSONItem
		  
		  If Method = "" then
		    if me.Debug then
		      System.DebugLog( "JSON-RPC" )
		      System.DebugLog( CurrentMethodName )
		      System.DebugLog( "json-rpc error: No method has been given" )
		      System.DebugLog( "json-rpc info: Method call has been ignored" )
		    end if
		    Return
		  End If
		  
		  Try
		    'Create the json-rpc Notification.
		    'A notification is without an ID parameter, no response will be given.
		    Req.Value("jsonrpc") = "2.0"
		    Req.Value("method") = Method
		    If Params <> nil and Params.IsArray then
		      Req.Value("params") = Params
		    End If
		    
		    'Send the JSONItem (as String with UTF8 encoding) to the server
		    Encoded = ConvertEncoding( Req.ToString, Encodings.UTF8 )
		    me.Write( Encoded )
		    
		    if me.Debug then
		      System.DebugLog( "JSON-RPC" )
		      System.DebugLog( CurrentMethodName )
		      System.DebugLog( "json-rpc accepted" )
		    end if
		    
		  Catch e As JSONException
		    'Exception catched, let's stop moving on and log to system.debuglog
		    
		    if me.Debug then
		      System.DebugLog( "JSON-RPC" )
		      System.DebugLog( CurrentMethodName + " >> JSONException" )
		      System.DebugLog( Str( e.ErrorNumber ) + " >> " + e.Message )
		    end if
		    
		  End Try
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event RequestReceived(Request As JSONItem, IsNotification As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ResponseReceived(Response As JSONItem, IsError As Boolean)
	#tag EndHook


	#tag Note, Name = For SERVER Use
		
		Not tested YET>>>>>
		
		If you want to use JSON-RPC as a server then do the following:
		Create a subclass called as you wish. Add "Shared Methods" for each method that can be called by a client.
		
		Let's say i have a shared method called "online" within the subclass of JSONRPCSocket
		A client would make a call (note this has no parameters you can however accept any parameter):
		{"jsonrpc": "2.0", "method": "online", "id": "1"}
		
		The response will be the output of the method, wich will be a JSONItem containing the following:
		{"result": "string,integer,boolean"} 
		It can hold an array of any json datatype, or any single json datatype value.
		
		You create a JSONItem and return that from your "Shared Method" named "online"
		If the return value = nil (eg the JSONItem) then it will parse null to the result.
		
		
	#tag EndNote

	#tag Note, Name = Future needs
		
		Better implementation for Batch Messages.
		See: http://www.jsonrpc.org/specification#batch 
		Splitting each message using },{  and keep them JSONItem valid.
		
		I think this can be made faster.
		
	#tag EndNote

	#tag Note, Name = Method
		
		Method will parse a Method (json) to the server, asking for a response.
		With Method there will always be a response from the server if there where no exceptions catched.
		
		Method is used like so:
		
		Dim JSONRPCSocket1 As new JSONRPCSocket
		Dim j As new JSONItem
		
		j.Append("myparam")
		j.Append("myparam2")
		
		JSONRPCSocket1.Method("ServerMethodName", j)
		
		if no parameters are needed then just use it like this:
		
		Dim JSONRPCSocket1 As new JSONRPCSocket
		Dim j As new JSONItem
		
		j.Append("myparam")
		j.Append("myparam2")
		
		JSONRPCSocket1.Method("TheMethodName")
	#tag EndNote

	#tag Note, Name = Notification
		A json-rpc notification will give the server a message, but no response will be given.
		Also no errors will be returned (other than internal class errors) by the server.
		
		To create a json-rpc notification:
		
		Dim JSONRPCSocket1 As new JSONRPCSocket
		Dim j As new JSONItem
		
		j.Append("myparam")
		j.Append("myparam2")
		
		JSONRPCSocket1.Notification("TheMethodName", j)
		
		Note params are not required, you may use it like:
		
		Dim JSONRPCSocket1 As new JSONRPCSocket
		Dim j As new JSONItem
		
		j.Append("myparam")
		j.Append("myparam2")
		
		JSONRPCSocket1.Notification("TheMethodName")
	#tag EndNote

	#tag Note, Name = RequestReceived Event
		
		RequestReceived will be called only when the remote machine makes a method call (via JSON-RPC).
		This is to be used as a server. That means that this class can be used 2 ways. 
		
		RequestReceived( Request As JSONItem, IsError As Boolean, IsNotification As Boolean )
		IsError will be true if there was an exception or the JSONItem was invalid. 
		You should only ignore the request when there was an Notification send.
		IsNotification tells you that the request will NEVER get a response (the client doesnt want a response).
		That means that even if there was an error, no error message will be send back. 
		
		The JSONItem for the Request will look like this:
		{"jsonrpc": "2.0", "method": "sum", "params": [1,2,4], "id": "1"}
		
		Telling you: the client made a request for the Method "sum" with parameters "1,2,3".
		If there is a "Shared Method" with the name "sum" in the "subclass" then it will automaticly be called.
		The response shall be given to the client automaticly. 
		
		There is nothing to be handled.
		It's done by using Introspection wich helps a good way.
		
	#tag EndNote

	#tag Note, Name = ResponseReceived Event
		ResponseReceived( Response As JSONItem, IsError As Boolean )
		
		The Response event will be raised for every data that's incoming (this is to be used as a client).
		The data is UTF8 encoded.
		
		The Response (JSONItem) will look like the folowing when IsError = False :
		{"jsonrpc": "2.0", "result": 19, "id": 4}
		The "jsonrpc" value will always be there it won't change unless the server has
		a newer version of json-rpc. The result will hold any kind of value, Integer, String....
		The id is the unique number for this message. This is handled internally. 
		
		The Response (JSONItem) will look like the folowing when IsError = True :
		{"jsonrpc": "2.0", "error": {"code": -32601, "message": "Method not found"}, "id": "1"}
		The "jsonrpc" value will always be there it won't change unless the server has
		a newer version of json-rpc. The "error" object (JSONItem) will parse some information about 
		the error that was given. Use the Constants in the class to compare them if needed. 
		The ERROR_ServerErrorStart and ERROR_ServerErrorEnd are possible but reserved for
		server implementations. The message can be of any use and is given by the server.
		
		Note:
		JSONExceptions will be catched and parse a NIL value to the 
		ResponseReceived event. The IsError value will be set to True.
	#tag EndNote

	#tag Note, Name = Updates
		
		3 Jan 2014
		Added: RequestReceived event, to be used as a server
		Added: Note about RequestReceived event
		Added: HandleMessage to handle each message. This is to be able to have Batch messages for the server use.
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		Debug As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLastID
			End Get
		#tag EndGetter
		LastID As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLastID As Integer = 0
	#tag EndProperty


	#tag Constant, Name = ERROR_InternalError, Type = Double, Dynamic = False, Default = \"-32603", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_InvalidParameters, Type = Double, Dynamic = False, Default = \"-32602", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_InvalidRequest, Type = Double, Dynamic = False, Default = \"-32600", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_MethodNotFound, Type = Double, Dynamic = False, Default = \"-32601", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_ParseError, Type = Double, Dynamic = False, Default = \"-32700", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_ServerErrorEnd, Type = Double, Dynamic = False, Default = \"-32099", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_ServerErrorStart, Type = Double, Dynamic = False, Default = \"-32000", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Address"
			Visible=true
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Debug"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastID"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
