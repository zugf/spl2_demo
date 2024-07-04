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

- Why do i need a notebook instead of just add the files to the app directory?

- If I upload a cell it seems to be stored in the data orchestrator but not uploaded to my app.
  
  So notebook cell (namespace app.my_slp2app, name _default) uploaded will not create the file
  opt/splunkbeta/etc/apps/my_spl2app/default/data/spl2/_default.spl2

  Nevertheless I can now access the data from the apps search using spl2.

- cell does not show namespace and name... need to click to see if correctly defined
- cell does not show if it is uploaded / up-to-date (how to visually distinguish between temporary modules and uploaded modules)

- a notebook normally is sequential. the current use is just strange... (need to upload the modules to be able to access them,
  not automatically can access the previous data cells)

- "Upload All" button (like "Run all"?)