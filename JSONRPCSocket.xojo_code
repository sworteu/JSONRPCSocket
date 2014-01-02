#tag Class
Protected Class JSONRPCSocket
Inherits TCPSocket
	#tag Event
		Sub DataAvailable()
		  'JSON-RPC response received.
		  Dim buff As String = me.ReadAll(Encodings.UTF8)
		  Dim RPCResponse As JSONItem
		  
		  Try
		    'To be sure we catch any exception
		    Response.Load( buff )
		    
		    if Response.HasName("error") then
		      'The "error" value is only there when it has an error
		      'We parse the JSONItem, and set the flag IsError in the Response event
		      
		      if me.Debug then
		        System.DebugLog( "JSON-RPC" )
		        System.DebugLog( CurrentMethodName + " >> JSON-RPC Response received" )
		        System.DebugLog( "json-rpc error: " + Response.Child("error").Value("message") )
		        if Response.Value("id") <> nil then
		          System.DebugLog( "json-rpc id: " + Str( Response.Value("id") ) )
		        end if
		      end if
		      
		      RaiseEvent ResponseReceived(RPCResponse, True)
		      
		    else
		      'No error, parse the JSONItem
		      
		      if me.Debug then
		        System.DebugLog( "JSON-RPC" )
		        System.DebugLog( CurrentMethodName + " >> JSON-RPC Response received" )
		        System.DebugLog( "json-rpc accepted" )
		        if Response.Value("id") <> nil then
		          System.DebugLog( "json-rpc id: " + Str(Response.Value("id") ) )
		        end if
		      end if
		      
		      RaiseEvent ResponseReceived(RPCResponse, False)
		      
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
	#tag EndEvent


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
		Event ResponseReceived(Response As JSONItem, IsError As Boolean)
	#tag EndHook


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

	#tag Note, Name = ResponseReceived Event
		ResponseReceived( Response As JSONItem, IsError As Boolean )
		
		The Response event will be raised for every data that's incoming. 
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


	#tag Property, Flags = &h0
		Debug As Boolean = False
	#tag EndProperty

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
