package commands 
{

		
		public function registerAviableCommands():Object { 

			var _commandClasses:Object = new Object();
			_commandClasses['names'] = new Array();
			_commandClasses['qualifiedNames'] = new Array();
			_commandClasses['runtimeClassRefs'] = new Array();

			_commandClasses['names'][0] = "DefaultCommand"		
			_commandClasses['qualifiedNames'][0] = "Commands::DefaultCommand";
			_commandClasses['runtimeClassRefs'][0] =  DefaultCommand as Class;		
			
			_commandClasses['names'][1] = "AddElement"		
			_commandClasses['qualifiedNames'][1] = "Commands::AddElement";
			_commandClasses['runtimeClassRefs'][1] =  AddElement as Class;
			
			_commandClasses['names'][2] = "RemoveElement"		
			_commandClasses['qualifiedNames'][2] = "Commands::RemoveElement";
			_commandClasses['runtimeClassRefs'][2] =  RemoveElement as Class;		
			
			_commandClasses['names'][3] = "NewSite"		
			_commandClasses['qualifiedNames'][3] = "Commands::NewSite";
			_commandClasses['runtimeClassRefs'][3] =  NewSite as Class;		
			
			_commandClasses['names'][4] = "NextPage"		
			_commandClasses['qualifiedNames'][4] = "Commands::NextPage";
			_commandClasses['runtimeClassRefs'][4] = NextPage as Class;

			_commandClasses['names'][5] = "PreviousPage"		
			_commandClasses['qualifiedNames'][5] = "Commands::PreviousPage";
			_commandClasses['runtimeClassRefs'][5] = PreviousPage as Class;

			_commandClasses['names'][6] = "SaveSite"		
			_commandClasses['qualifiedNames'][6] = "Commands::SaveSite";
			_commandClasses['runtimeClassRefs'][6] =  SaveSite as Class;	
			
			_commandClasses['names'][7] = "LoadSite"		
			_commandClasses['qualifiedNames'][7] = "Commands::LoadSite";
			_commandClasses['runtimeClassRefs'][7] =  LoadSite as Class;	
			
			_commandClasses['names'][8] = "Select"		
			_commandClasses['qualifiedNames'][8] = "Commands::Select";
			_commandClasses['runtimeClassRefs'][8] =  Select as Class;	
			
			_commandClasses['names'][9] = "EditElement"		
			_commandClasses['qualifiedNames'][9] = "Commands::EditElement";
			_commandClasses['runtimeClassRefs'][9] =  EditElement as Class;	
			
			_commandClasses['names'][10] = "Settings"		
			_commandClasses['qualifiedNames'][10] = "Commands::Settings";
			_commandClasses['runtimeClassRefs'][10] =  Settings as Class;	
			
			_commandClasses['names'][11] = "GotoToPageId"		
			_commandClasses['qualifiedNames'][11] = "Commands::GotoToPageId";
			_commandClasses['runtimeClassRefs'][11] =  GotoToPageId as Class;	
			
			
			
			return _commandClasses;
			
		}
		
	

}