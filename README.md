# vs-installer-script-creator
Creates an auto installer script for Visual Studio given a .vsconfig file. This script generates another .bat file that will install Visual Studio (Community 2022) with the components provided in the configuration file. If no configuration file is provided no script is created. [How to export the .vsconfig](https://learn.microsoft.com/en-us/visualstudio/install/import-export-installation-configurations?view=vs-2022)

The auto installer script itself creates a temp .vsconfig on the directory it is executed and then uses winget with the override option to install Visual Studio and its components. **If not executed as administrator it will prompt for confimation** otherwise it will install quietly. Once the process is done it will delete the temp file.

I made this to install necesary dependencies on computers of non-programmer users.
