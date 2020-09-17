
	Set Wshell = CreateObject("WScript.Shell")
	Set FSO = CreateObject("Scripting.FileSystemObject")
	Set AutoHelper = CreateObject("AutomationHelper.AutomationLayerHelper")
	Set args = WScript.Arguments
	sPath = args.Item(0)
	ISVersion = args.Item(1)

	ISWI = "ISWiAuto"+ISVersion+".ISWiProject"
	Set pProject = CreateObject(ISWI) 
		
    pProject.OpenProject sPath, True 
	

	Set pProdConfig1 = pProject.ISWiProductConfigs("AMD64_strict")
	Set pProdConfig2 = pProject.ISWiProductConfigs("AMD86_strict")

	'Setting Platform Validation to Strict. Use 1 for Strict, 0 for Linient
'	pProdConfig1.PlatformValidation = 1
'	pProdConfig2.PlatformValidation = 1

	pProdConfig1.ArchitectureValidation = 1
	pProdConfig2.ArchitectureValidation = 1
	
	pProject.SaveProject
	pProject.CloseProject
	
	'Define Product Configuration name in Array
	strPConfig = Array("AMD64_strict", "AMD86_strict")
	
	RetVal = 1

	For j = 0 To UBound(strPConfig) 
		'Query to check value in Table ISProductConfigurationProperty
		pSQL = "SELECT `Value` FROM `ISProductConfigurationProperty` WHERE `ISProductConfiguration_` = '"&strPConfig(j)&"' AND `Property` = 'PlatformValidation'"	
		Fail = 0
		'Execute Query
		Call AutoHelper.SQLQuery(pSQL, sPath, ismProperty)
		'Compare Result
		Call AutoHelper.compare("1", ismProperty, i, Fail)
		
		RetVal = Fail
		If RetVal = 1 Then
			'Stop the execution if RetVal = 1
			WScript.echo "-1"
			WScript.Quit
		End If
			
	Next

'Sending message to QTP
If RetVal = 0 Then
	WScript.echo "0"
Else
	WScript.echo "-1"
End If
		

Set Wshell = Nothing
Set FSO = Nothing
Set AutoHelper = Nothing
Set args = Nothing

