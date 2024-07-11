%rpiを削除
clear rpi 
%rpi接続設定
%家用
%rpi = raspi('192.168.0.53', 'pi', 'milkyway');
%大学用
rpi = raspi('10.24.84.39', 'pi', 'milkyway'); 
%電源LED(赤)の下のステータスLED(緑)をledとして定義
led = rpi.AvailableLEDs{1};

%Lチカforループ(1秒間隔で点滅)
%>|matlab|
for i = 1:10
    writeLED(rpi, led, 0);
    pause(1);
    writeLED(rpi, led, 1);
    pause(1);
end
%LEDの制御を解放
system(rpi, 'echo "mmc0" | sudo tee /sys/class/leds/led0/trigger');
%rpiを削除
clear rpi