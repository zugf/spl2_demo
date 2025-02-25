# Demo

1. Download the splunkbeta.deb package from [Splunk SPL2 Public Beta](https://voc.splunk.com/preview/spl2-appdev-beta) 

Currently splunkbeta-9.2.2.20240415-51a9cf8e4d88-linux-2.6-amd64.deb

2. Build docker image

```sh
docker build -t splunkbeta . 
```

3. Run docker image (interactive - since splunk will ask for license confirmation)

```sh
docker run --rm -it -p 8001:8000 splunkbeta
```

Command will keep splunk running till it gets terminated with Ctrl-C (similar to splunk-docker project)

4. Open Splunk Web UI

[Web UI](127.0.0.1:8001/en-US/app/search/search)

5. Install demo app using Web UI

Download app from Github 

[sample_spl2_buttercup](https://github.com/splunk/splunk-app-examples/tree/master/spl2-sample-apps/sample_spl2_buttercup)

I did not find a app package, so I created one.

Clone the github repo and packed the folder plunk-app-examples\spl2-sample-apps\sample_spl2_buttercup to the archive sample_spl2_buttercup.tar.gz

I used the WebUI to install this file

[Web UI - Upload App](http://127.0.0.1:8001/en-US/manager/appinstall/_upload)
