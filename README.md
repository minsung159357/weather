# weather data using Elastic stack


## 1. Team

👥 팀명 : 구구구칠

|<img src="https://avatars.githubusercontent.com/u/87555330?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/55776421?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/71498489?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/82265395?v=4" width="150" height="150"/>|
|:-:|:-:|:-:|:-:|
|김민성<br/>[@minsung159357](https://github.com/minsung159357)|SeulGi_LEE<br/>[@seulg2027](https://github.com/seulg2027)|HanJH<br/>[@letsgojh0810](https://github.com/letsgojh0810)|구민지<br/>[@user0830](https://github.com/user0830)|


## 2. Project intro & subject

💡 자기주도적 학습 기간 : `2025.01.19` ~ `2025.01.21`

💡 개요 : 데이터를

💡 주제 : 

💡 데이터 수집 : 


## 3. Stack and Tools

## 4. Database

<aside>

    📁 파일명

    1. [dataSet] weather_info.csv
    2. [logstash] weather_info.conf
    3. weather_info

</aside>

## 5. Practice course



## 6. Trouble Shooting
# 파일명 오류
logstash 와 jdbc 를 연동하는 설정파일(mysql-logstash.conf) 수정 중 파일명을 잘못 기재하여 오류발생.

![image](https://github.com/user-attachments/assets/42263ffd-a0ef-479f-aaa2-bb010e9a4a7f)

mysql-connector-java-8.0.32.jar --->mysql-connector-j-8.0.33.jar 수정완료.

![image](https://github.com/user-attachments/assets/81240646-edfb-455f-9b3a-c40e00418f77)

# jdbc 연결 오류

![image](https://github.com/user-attachments/assets/40a2c384-6f9b-4392-bef9-f4f5efdfff93)

조건없이 전체 데이터를 조회하는 과정 중 tracking_column 값을 주석처리하여 오류 발생. 

![image](https://github.com/user-attachments/assets/b7d35e4a-637e-433a-a614-7ad2ee5c2df1)

use_column_value = false 값으로 변경하여 해결.

![image](https://github.com/user-attachments/assets/4b0e9883-8b4d-49c9-8fd9-961c1842629c)

## 7. Review
