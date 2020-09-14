sPath = "C:\InstallShield 2020 Projects\My Project Name-69.ism"

Set pProject = createObject("ISWiAuto26.ISWiProject")

pProject.OpenProject sPath, True

'Dim pComponent As ISWiComponent

'Set pComponent = m_pProject.AddComponent ("New_Component")

set prodconf = pProject.ISWiProductConfigs("Product Configuration 1")

prodconf.Title= "Flexera"
pProject.SaveProject

prodconf.Subject= "InstallShield"
pProject.SaveProject


Set rel = prodconf.ISWIReleases.Item("Release 1")

rel.SignatureDescription = "test"
pProject.SaveProject

test = rel.SignatureDescription

MsgBox test

'Set rel = prodconf.ISWIReleases.Item("Release 1")

'rel.DigitalCertificateInfo = "C:\Users\sgadiparthi\Desktop\Digital sign files\SHA1\AcressoTestCA.pfx"
'pProject.SaveProject

'test = rel.DigitalCertificateInfo

'MsgBox test

'rel.DigitalCertificateInfo = " Store: MY, StoreLocation: User, Subject: AcressoTestCA.pfx"
rel.DigitalCertificateInfo ="<PATH_TO_SHA1_FILES>\AcressoTestCA.pfx?dual"
pProject.SaveProject

test = rel.DigitalCertificateInfo

MsgBox test

rel.certificatePassword = "123"
pProject.SaveProject

test = certificatePassword
MsgBox test

rel.SignLauncher = "TRUE"
pProject.SaveProject
test1 = rel.SignLauncher
MsgBox test1

rel.SignFiles = "TRUE"
pProject.SaveProject
test1 = rel.SignFiles

MsgBox test1

pProject.SaveProject
rel.Build

 

 