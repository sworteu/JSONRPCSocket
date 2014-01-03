#tag Window
Begin Window WindowMain
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   13213695
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "JSON-RPC Example"
   Visible         =   True
   Width           =   600
   Begin JSONRPCSocket JSONRPC
      Address         =   ""
      Debug           =   False
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      LastID          =   0
      Left            =   40
      LockedInPosition=   False
      Port            =   0
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   40
      Width           =   32
   End
   Begin ServerSocket Server
      Height          =   32
      Index           =   -2147483648
      Left            =   40
      LockedInPosition=   False
      MaximumSocketsConnected=   50
      MinimumSocketsAvailable=   2
      Port            =   9999
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   40
      Width           =   32
   End
   Begin CheckBox CheckBoxServer
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Is Server?"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      State           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   14
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   113
   End
   Begin PushButton PushButtonListen
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Listen"
      Default         =   False
      Enabled         =   False
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   46
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton PushButtonConnect
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Connect"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   46
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Label LabelPort
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   164
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      Text            =   "Port:"
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   14
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin TextField TextFieldPort
      AcceptTabs      =   False
      Alignment       =   2
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   175
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   "#####"
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "9999"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   46
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin Label LabelAddress
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   326
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      Text            =   "Address:"
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   14
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   109
   End
   Begin TextField TextFieldAddress
      AcceptTabs      =   False
      Alignment       =   2
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   326
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "127.0.0.1"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   46
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   109
   End
   Begin Label LabelClient
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      Text            =   "Client:"
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   14
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin TextField TextFieldMethod
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "online"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   129
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   100
   End
   Begin Label LabelMethod
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      Text            =   "Method name:"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   97
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Listbox ListboxMessages
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   True
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   200
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Method	Params	JSON"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   180
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
      _ScrollWidth    =   -1
   End
   Begin PushButton PushButtonDisconnect
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Disconnect"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   80
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton PushButtonSend
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Send"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   129
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Constant, Name = WINDOW_TITLE, Type = String, Dynamic = False, Default = \"JSON-RPC Example", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events JSONRPC
	#tag Event
		Sub RequestReceived(Request As JSONItem, IsNotification As Boolean)
		  'Only to be used as server
		End Sub
	#tag EndEvent
	#tag Event
		Sub ResponseReceived(Response As JSONItem, IsError As Boolean)
		  if Not IsError and Response <> nil then
		    WindowMain.ListboxMessages.AddRow Str(me.LastID), Response.Value("result").StringValue, Response.ToString
		  elseif Response = nil then
		    'An exception has been catched
		    WindowMain.ListboxMessages.AddRow "Exception catched", "no info", ""
		  else
		    'Only an error
		    WindowMain.ListboxMessages.AddRow "Error", Response.Child("error").Value("message").StringValue, Response.ToString
		  end if
		End Sub
	#tag EndEvent
	#tag Event
		Sub Connected()
		  self.Title = WINDOW_TITLE + " - Client Connected"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Server
	#tag Event
		Function AddSocket() As TCPSocket
		  Dim sock As TCPSocket = New JSONRPCHost
		  
		  WindowMain.Title = WindowMain.WINDOW_TITLE + " - Socked added"
		  
		  Return sock
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxServer
	#tag Event
		Sub Action()
		  'Server
		  PushButtonListen.Enabled = Me.Value
		  
		  'Client
		  PushButtonConnect.Enabled = Not me.Value
		  TextFieldMethod.Enabled = Not me.Value
		  PushButtonSend.Enabled = Not me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButtonListen
	#tag Event
		Sub Action()
		  Server.Listen
		  
		  TextFieldAddress.Text = Server.LocalAddress
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButtonConnect
	#tag Event
		Sub Action()
		  JSONRPC.Address = TextFieldAddress.Text
		  JSONRPC.Port = Val(TextFieldPort.Text)
		  JSONRPC.Connect()
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButtonDisconnect
	#tag Event
		Sub Action()
		  Server.StopListening()
		  JSONRPC.Disconnect()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButtonSend
	#tag Event
		Sub Action()
		  if JSONRPC.IsConnected then
		    Dim j As new JSONItem
		    j.Append(True)
		    j.Append("online")
		    JSONRPC.Method( TextFieldMethod.Text, j )
		  end if
		End Sub
	#tag EndEvent
#tag EndEvents
