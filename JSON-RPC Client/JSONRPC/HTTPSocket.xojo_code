#tag Class
Protected Class HTTPSocket
Inherits Xojo.Net.HTTPSocket
	#tag Event
		Sub DataAvailable()
		  'When we recieve data, we first need to know if it's actually valid JSON (UTF-8) data.
		  
		  
		  
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

	#tag Method, Flags = &h21
		Private Shared Function GetNewID() As UInt64
		  JSONRPC.HTTPSocket.LastID = ( JSONRPC.HTTPSocket.LastID + 1 )
		  
		  Return JSONRPC.HTTPSocket.LastID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MethodRequest(Method As Text, Params() As Auto)
		  'Creates a JSON RPC request with an id, method and optional params
		  
		  'Stop doing anything if the Method name is not set.
		  If Method = "" Then Return
		  
		  'Get a new JSON RPC ID for this Request.
		  Dim ID As UInt64 = JSONRPC.HTTPSocket.GetNewID
		  
		  'Create a Xojo.Core.Dictionary for easy JSON creation
		  Dim Req As New Xojo.Core.Dictionary
		  
		  Req.Value("jsonrpc") = JSONRPC_VERSION
		  Req.Value("method") = Method
		  Req.Value("params") = 
		  Req.Value("id") = ID
		  
		  'Clear RequestHeaders in case these are automaticly set.
		  Self.ClearRequestHeaders
		  
		  'Set the POST content and mime type (content-type), then send
		  Self.SetRequestContent( Xojo.Data.GenerateJSON( Req ), "application/json" )
		  Self.Send("POST", xURL)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationRequest(Method As Text, Params() As Auto)
		  'Creates a JSON RPC notification (a request without id and without response)
		  
		  'Stop doing anything if the Method name is not set.
		  If Method = "" Then Return
		  
		  'Create a Xojo.Core.Dictionary for easy JSON creation
		  Dim Req As New Xojo.Core.Dictionary
		  
		  Req.Value("jsonrpc") = JSONRPC_VERSION
		  Req.Value("method") = Method
		  Req.Value("params") = 
		  
		  'Clear RequestHeaders in case these are automaticly set.
		  Self.ClearRequestHeaders
		  
		  'Set the POST content and mime type (content-type), then send
		  Self.SetRequestContent( Xojo.Data.GenerateJSON( Req ), "application/json" )
		  Self.Send("POST", xURL)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ResponseReceived(Response As Xojo.Core.Dictionary)
	#tag EndHook


	#tag Note, Name = JSON RPC HTTP CLIENT
		
		The JSONRPCSocket class is meant to be used as a client only. There is no server-side implementation.
		It's using Xojo.Net.HTTPSocket as it's super class. 
		
		Connecting to any HTTP type JSON RPC service is possible.
		
		Most cryptocurrency daemons use JSON RPC for example.
	#tag EndNote


	#tag Property, Flags = &h21
		Private Shared LastID As Integer = 1
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
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastID"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
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
			EditorType="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
