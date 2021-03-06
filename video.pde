/*

Created 2018/05/25
By takeyourcap@foxmail.com

*************************************************************************************
1, Copy the 4 movies that will be played to the sketch "data" folder, rename them 
   to "M0.mov"(default), "M1.mov", "M2.mov", "M3.mov", "M4.mov", respectively.   
   将所需视频复制到项目文件夹，并重新命名为相应的文件名（M1.mov, M2.mov, M3.mov, M4.mov）。
2, Install Arduino（IDE) and Processing software. For Processing, the "video" library
   need to be downloaded separately, Select "Add Library..." from the "Import Library
   ..." submenu within the Sketch menu.  
   video库需单独下载。打开Sketch菜单--导入库--添加库，搜索video库并下载。
*************************************************************************************
 

*/
import processing.video.*;                                       // 导入video库
import processing.serial.*;                                      // 导入串口库
Serial myPort;                                                   // 定义串口变量myPort
Movie M,M0,M1,M2,M3,M4;                                          // 定义视频变量
int r=255, g=255, b=255, dista=0;                                // 定义并初始化红，绿，蓝颜色变量
int event=100;                                                   // 定义并初始化事件变量

void setup() {                                                   // 初始化Processing
  size(1280, 720);                                               // 设置画面长宽
  M0 = new Movie(this, "M0.mov");                                // 导入视频M0
  M1 = new Movie(this, "M1.mov");                                // 导入视频M1
  M2 = new Movie(this, "M2.mov");                                // 导入视频M2
  M3 = new Movie(this, "M3.mov");                                // 导入视频M3
  M4 = new Movie(this, "M4.mov");                                // 导入视频M4
  M=M0;                                                          // 定义视频变量M并初始化为M0
  M.loop();                                                      // 循环播放M
 // M2.play();                                                   //
 
  println("Available serial ports:");                            // 输出可用串口
  printArray(Serial.list());                                     // 输出可用串口
  myPort = new Serial(this, Serial.list()[0], 9600);             // 设置串口变量myPort为相应的串口
  
}

void draw() {                                                    // Processing 主函数（循环调用）

    switch (event){                                              // 事件判断  
      case 0:                                                    // 若事件为0，播放默认视频
        M.play();
        image(M, 0, 0,width,height);
        break;
      case 1:                                                    // 若事件为1，播放视频1
        M0.stop();M2.stop();M3.stop();M4.stop();
        M=M1;
        M1.play();
        image(M, 0, 0,width,height);
        break;
      
      case 2:                                                    // 若事件为2，播放视频2
        M0.stop();M1.stop();M3.stop();M4.stop();
        M=M2;
        M2.play();
        image(M, 0, 0,width,height);
        break;
       
      case 3:                                                    // 若事件为3，播放视频3
        M0.stop();M1.stop();M2.stop();M4.stop();
        M=M3;
        M3.play();
        image(M, 0, 0,width,height);
        break;
      case 4:                                                    // 若事件为4，播放视频4
        M0.stop();M1.stop();M2.stop();M3.stop();
        M=M4;
        M4.play();
        image(M, 0, 0,width,height);
        break;
      case 5:                                                    // 若事件为5，暂停当前视频30秒，回到默认视频并播放
        M1.stop();M2.stop();M3.stop();M4.stop();M0.stop();
        delay(30000);
        M=M0;
        M0.play();
        image(M, 0, 0,width,height);
        break;
      default:                                                    // 若无相应事件，播放默认视频
        M1.stop();M2.stop();M3.stop();M4.stop();M0.stop();
        M=M0;
        M0.play();
        image(M, 0, 0,width,height);
        break;
      
    }
     int sec=second();
     textSize(35); 
     fill(0);
     text(event, 5*width/10, height/2); 
     text(sec, 2*width/10, height/2);
     print(event);
}

void movieEvent(Movie m) {                                       // 视频中断函数

    M.read();                                                    // 若有活动视频，读取活动视频
  
}
void serialEvent(Serial s) {                                     // 串口中断函数
    event = s.read();                                            // 若有活动串口，读取串口数据
 }
