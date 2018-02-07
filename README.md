# jpPluginBuildScripts
modified ShiVa 2.0 plugin build scripts

These scripts can be used to re-build ShiVa 2.0 plugins from the command line without opening Visual Studio, Xcode, Android Studio etc. - useful if you need to re-build a large number of projects automatically.

## How to use
1. Copy the script file(s) to your project directory and rename it. The name does not matter, it's just so you can keep track of it.
2. Edit the script(s) to fit your project. The variables you need to fill in are clearly marked. PLUGIN_ID and PLUGIN_NAME must have the values you entered in ShiVa when you first created the plugin.
3. Run the script(s) through the terminal (Linux/macOS) or CMD/PowerShell (Windows)

Naturally, these scripts depend on Visual Studio, Android Studio, gcc, or Xcode, depending on the platform and target.
