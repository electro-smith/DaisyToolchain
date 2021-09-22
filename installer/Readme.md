# Daisy Toolchain Installer Creator

## Notes:

- The default NSIS install will throw errors when updating PATH variables > 1024 chars.  
For this reason we use the "long strings" special build. First install the regular version of NSIS via the installer.  
Next download the [long strings build](https://nsis.sourceforge.io/Special_Builds).  
Drag the contents of the long strings bin and Stubs folders into the default install bin and stub folders respectively.  
Make sure to choose 'replace files'.  

