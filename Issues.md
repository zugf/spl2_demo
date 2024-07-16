# Issues


## first impression

saw the structure of the demo apps and thought I can just add the specific .spl2 files in the app/data/spl2 directory
and everything will work.

Instead it is only working if I use WebUI install - or VSCode notebooks to upload the spl2 in some hidden place.


## App installation

- apps only seem to work if installed via WebUI

    copied to etc/apps does not work even after splunk restart

    neither does `splunk app install`



##  Handling

### Current handling of SPL2 orchestrator and notebooks not really nice

- SPL2 is stored outside of the app / changes uploaded with vscode notebooks
  only "splunk download-spl2-modules app <app-name> -dest default" will store the modules in the app dir

  all other Splunk functionality is just configured by conf files and can be directly edited in the app folder
  ( for example macros, transforms, props,...)
  (with maybe a splunk refresh/restart)

  So SPL2 orchestrator should be included in Splunk or be at least transparent for the user

- vscode notebook is used as a kind of upload tool

- For me a notebook does not feel right for that use case of programming an spl2 app
  
  - a notebook is something sequential (see jupyter, mathematica, matlab), so it can be played from top to bottom
    and each cell might be dependent of previous cells but not cells that are following

  - here the cells are kind more of a mesh and each of them need to be uploaded to the spl2 orchestrator

--> Better: just use conf files. If VScode integration is wanted, maybe download/upload/synchronize the app folder in vscode
    with the installed code on the searchhear

### SPL2 notebooks (bugs + missing features)

- cell does not show namespace and name... need to click to see if correctly defined
- cell does not show if it is uploaded / up-to-date 
- How to visually distinguish between temporary / test modules and uploaded modules?
- "Upload All" button (like "Run all"?)
- Cells that only define functions or exports will raise an error if executed.

    Error: No statements found in SPL2. Please assign at least one statement name using "$". For example: `$my_statement = from _internal`

- markdown cells will change to code cells after restart of visual studio code

- if code cells are changed to markdown the output is still part of the spl2 notebook source (but not visible in the notebook UI)

### simplify switch SPL-->SPL2

- "Global App": offer an app where everything is already exported to be used for an admin, so only a syntax switch in the search
  field is neccessary
  (as long as SPL is supported, there is no use to restrict the SPL2 use if the data can still be queried with SPL)
  
## Language

- typed dataset possible?

- materialized views... if data is used multiple times in an spl? Or is that automatically optimized by splunk
