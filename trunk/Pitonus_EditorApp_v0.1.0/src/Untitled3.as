Running process: C:\Program Files (x86)\FlashDevelop\Tools\fdbuild\fdbuild.exe "H:\AS3\Pitonus\pitonus_src\trunk\Pitonus_EditorApp_v0.1.0\Pitonus_EditorApp_v0.1.0.as3proj" -ipc 1dead8e4-390f-4aab-9974-faaca7887abf -compiler "H:\FlexSDK\flex_sdk_4.1.0.16032" -library "C:\Program Files (x86)\FlashDevelop\Library"
Using the Flex Compiler Shell.
Building Pitonus_EditorApp_v0.1.0
mxmlc -load-config+=obj\Pitonus_EditorApp_v0.1.0Config.xml -debug=true -incremental=true -benchmark=false -static-link-runtime-shared-libraries=true -o obj\Pitonus_EditorApp_v0.1.0634449493185255917
Incremental compile of 3
 Loading configuration file H:\FlexSDK\flex_sdk_4.1.0.16032\frameworks\flex-config.xml
Loading configuration file H:\AS3\Pitonus\pitonus_src\trunk\Pitonus_EditorApp_v0.1.0\obj\Pitonus_EditorApp_v0.1.0Config.xml
Files changed: 2 Files affected: 0
obj\Pitonus_EditorApp_v0.1.0634449493185255917 (706082 bytes)
(fcsh)Build succeeded
Done(0)
[Starting debug session with FDB]
[SWF] H:\AS3\Pitonus\pitonus_src\trunk\Pitonus_EditorApp_v0.1.0\bin\testApp.swf - 1,505,924 bytes after decompression.
ProjectPanel.null object
CanvasControl.[object ProjectControl] object
[Fault] ExternalInterface is not available. ExternalInterface requires browser that support NPRuntime


... Emulate load


JSBridge.callJs > func: jsConsole
[Fault] ExternalInterface is not available. ExternalInterface requires browser that support NPRuntime

CanvasControl.[object Editor] object
[UnloadSWF] H:\AS3\Pitonus\pitonus_src\trunk\Pitonus_EditorApp_v0.1.0\bin\testApp.swf










							{
							"elementType" 	: "TextBlock",
							"text" 		: "PROJECT:",
							"w"				: "180",
							"h"				: "450",
							"marginX"		: "0",
							"marginY"		: "0",
							"fontColor"		: "0x00974B",
							"inline"		: "true"
							},
							
							
							
							
							{
							"elementType" 	: "TextButton",
							"name" 			: "new name",
							"label"			: "New Project",
							"marginY"		: "20",
							"w" 			: "180",
							"h" 			: "30", 
							"action" 		: "NewSite",
							"inline"		: "true"
							},
							
							{
							"elementType" 	: "TextButton",
							"name" 			: "new name",
							"label"			: "Load Default Project",
							"marginY"		: "10",
							"w" 			: "180",
							"h" 			: "30", 
							"action" 		: "LoadSite",
							"inline"		: "true"
							},
							
							{
							"elementType" 	: "TextButton",
							"name" 			: "new name",
							"label"			: "Save Project",
							"marginY"		: "10",
							"w" 			: "180",
							"h" 			: "30", 
							"action" 		: "SaveSite",
							"inline"		: "true"
							},