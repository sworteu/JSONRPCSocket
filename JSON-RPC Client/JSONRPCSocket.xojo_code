#tag Class
Protected Class JSONRPCSocket
Inherits Xojo.Net.HTTPSocket
	#tag Event
		Sub Error(err as RuntimeException)
		  RaiseEvent Error( err )
		End Sub
	#tag EndEvent

	#tag Event
		Sub FileReceived(URL as Text, HTTPStatus as Integer, File as xojo.IO.FolderItem)
		  'NOT USED as we don't do downloads, just JSON-RPC
		End Sub
	#tag EndEvent

	#tag Event
		Sub HeadersReceived(URL as Text, HTTPStatus as Integer)
		  'Verify if this is an JSON RPC response we received.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub PageReceived(URL as Text, HTTPStatus as Integer, Content as xojo.Core.MemoryBlock)
		  Dim JSONText As Text 
		  Dim JSON As Xojo.Core.Dictionary 'No batch responses allowed (yet)
		   
		  JSONText = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		  
		  Try
		    JSON = Xojo.Data.ParseJSON(JSONText)
		  Catch e As Xojo.Data.InvalidJSONException
		    RaiseEvent Error( e )
		    Return 'Don't move on, as the JSON is not valid
		  End Try
		  
		  Select Case HTTPStatus
		  Case 200
		    'Message received OK
		    
		    If JSON.HasKey("result") = True And JSON.HasKey("error") = True Then
		      'incorrect message, trow error
		      RaiseEvent RPCError(URL, HTTPStatus, JSON)
		    End If
		    
		    If JSON.HasKey("result") Then
		      'Message success
		      
		      If JSON.HasKey("id") Then
		        'id Key is there
		        
		        RaiseEvent ResponseReceived(URL, JSON)
		        
		      Else
		        'No id ?!? - required, trow error
		        
		        RaiseEvent RPCError(URL, HTTPStatus, JSON)
		        
		      End If
		      
		    Else
		      If JSON.HasKey("error") Then
		        
		        'JSON RPCError 
		        RaiseEvent RPCError(URL, HTTPStatus, JSON)
		        
		      Else
		        'No result key or error key ?!?
		        
		      End If
		    End If
		    
		  Else
		    'HTTP Error 
		    
		    RaiseEvent RPCError(URL, HTTPStatus, JSON)
		    
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  'Default true
		  Self.ValidateCertificates = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(RemoteURL As Text)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  'Default true
		  Self.ValidateCertificates = True
		  
		  'Set URL trough the URL computed property
		  Self.URL = RemoteURL
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MethodRequest(Method As Text, Optional Params() As Auto)
		  'Creates a JSON RPC request with an id, method and optional params
		  Static LastID As Integer = 1
		  
		  Dim JSONText As Text
		  Dim Data As Xojo.Core.MemoryBlock
		  
		  'Stop doing anything if the Method name is not set.
		  If Method = "" Then Return
		  
		  'Create a Xojo.Core.Dictionary for easy JSON creation
		  Dim Req As New Xojo.Core.Dictionary
		  
		  'Add the required json-rpc version
		  Req.Value("jsonrpc") = JSONRPC_VERSION
		  
		  'Add the method value
		  Req.Value("method") = Method
		  
		  'Add the params value
		  If Params <> Nil Then
		    If Params.Ubound <> -1 Then
		      Req.Value("params") = Params 'Array of items
		    End If
		  End If
		  
		  'Add the id value
		  Req.Value("id") = LastID
		  
		  'Set mLastSendID
		  mLastSendID = LastID
		  
		  'Clear RequestHeaders in case these are automaticly set.
		  Self.ClearRequestHeaders
		  
		  'Set the POST content and mime type (content-type), then send
		  JSONText = Xojo.Data.GenerateJSON( Req )
		  Data = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(JSONText)
		  Self.SetRequestContent( Data, "application/json" )
		  Self.Send("POST", xURL)
		  
		  'Make a new LastID for the next rpc method call
		  LastID = LastID + 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationRequest(Method As Text, Optional Params() As Auto)
		  'Creates a JSON RPC notification (a request without id and without response)
		  
		  'Stop doing anything if the Method name is not set.
		  If Method = "" Then Return
		  
		  'Create a Xojo.Core.Dictionary for easy JSON creation
		  Dim Req As New Xojo.Core.Dictionary
		  Dim Data As Xojo.Core.MemoryBlock
		  Dim JSONText As Text
		  
		  'Add the json-rpc version to the Notification
		  Req.Value("jsonrpc") = JSONRPC_VERSION
		  
		  'Add the method name to the Notification
		  Req.Value("method") = Method
		  
		  'Add the paramters to the Notification 
		  If Params <> Nil Then
		    If Params.Ubound <> -1 Then
		      If Params.Ubound = 0 Then
		        Req.Value("params") = Params(0) 'Single item
		      Else
		        Req.Value("params") = Params 'Array of items
		      End If
		    End If
		  End If
		  
		  'Clear RequestHeaders in case these are automaticly set.
		  Self.ClearRequestHeaders
		  
		  'Set the POST content and mime type (content-type), then send
		  JSONText = Xojo.Data.GenerateJSON( Req )
		  Data = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(JSONText)
		  Self.SetRequestContent( Data, "application/json" )
		  Self.Send("POST", xURL)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Error(ErrException As RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ResponseReceived(URL As Text, Response As Xojo.Core.Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RPCError(URL As Text, HTTPStatus As Integer, Response As Xojo.Core.Dictionary)
	#tag EndHook


	#tag Note, Name = JSON RPC HTTP CLIENT
		
		The JSONRPCSocket class is meant to be used as a client only. There is no server-side implementation.
		It's using Xojo.Net.HTTPSocket as it's super class. 
		
		Connecting to any HTTP type JSON RPC service is possible.
		
		Most cryptocurrency daemons use JSON RPC for example.
	#tag EndNote


	#tag Property, Flags = &h21
		Private mLastSendID As Integer = 1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return xURL
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  xURL = value
			End Set
		#tag EndSetter
		URL As Text
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared xRequests As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private xURL As Text
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

	#tag Constant, Name = JSONRPC_VERSION, Type = Text, Dynamic = False, Default = \"2.0", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
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
		#tag ViewProperty
			Name="URL"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValidateCertificates"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
