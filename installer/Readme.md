# Daisy Toolchain Installer Creator

## Notes:

- The default NSIS install will throw errors when updating PATH variables > 1024 chars.  
For this reason we use the "long strings" special build. First install the regular version of NSIS via the installer.  
Next download the [long strings build](https://nsis.sourceforge.io/Special_Builds).  
Drag the contents of the long strings bin and Stubs folders into the default install bin and stub folders respectively.  
Make sure to choose 'replace files'.  

- Creating the NSIS templates:
  - First run without the templates to have cpack create the default ones.
  - Next copy from `./build/_Cpack_Packages/win64/NSIS` `NSIS.InstallOptions.ini` and `project.nsi`  
  to the installer dir as `NSIS.installoptions.ini.in` and `NSIS.template.in` respectively.
  - The install options template should be edited to say the PATH *is* edited by default.
  - The States of the buttons should be changes accordingly.
  - In `NSIS.template.in` the states have to be hardcoded. This can be done with  
  `StrCpy $ADD_TO_PATH_CURRENT_USER "1"`
  - In addition, all of the stuff related to the start menu needs to be commented out to remove that page.
  - This can require some trial and error.