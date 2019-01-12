[![](https://img.shields.io/badge/author-XiaYanji-brightgreen.svg)](https://github.com/callmefisher/rtmp-hls-flv)
[![V](https://img.shields.io/badge/version-v1.0.0-ff69b4.svg)](https://github.com/callmefisher/rtmp-hls-flv)

# rtmp-hls-flv
rtmp推流, 三种方式拉流
## rtmp-hls-flv是什么?
提供rtmp推流, 可以使用rtmp, hls, http-flv三种方式拉流的容器



## 如何使用

* step1: pull container docker pull xiayanji/rtmp-hls-flv:v1.0
* step2: start container docker run -d -p 80:80 -p 1935:1935  xiayanji/rtmp-hls-flv:v1.0
* step3: rtmp推流
  * ffmpeg -re -i ~/test.mp4 -r 30 -s 480x320 -threads 2 -vcodec libx264 -acodec aac -f flv "rtmp://127.0.0.1/live/stream1"
* step4: 拉流
  * rtmp 
   * ffplay "rtmp://127.0.0.1/live/stream1"
  * hls
   * ffplay "http://127.0.0.1/hls/stream1.m3u8"
  * http-flv
   * ffplay "http://127.0.0.1/live?app=live&stream=stream1"
