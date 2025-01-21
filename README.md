# weather data using Elastic stack


## 1. Team

👥 팀명 : 구구구칠

|<img src="https://avatars.githubusercontent.com/u/87555330?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/55776421?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/71498489?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/82265395?v=4" width="150" height="150"/>|
|:-:|:-:|:-:|:-:|
|김민성<br/>[@minsung159357](https://github.com/minsung159357)|SeulGi_LEE<br/>[@seulg2027](https://github.com/seulg2027)|HanJH<br/>[@letsgojh0810](https://github.com/letsgojh0810)|구민지<br/>[@minjee83](https://github.com/minjee83)|


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

> ### 📌 id INT PRIMARY KEY AUTO_INCREMENT,     -- 아이디

## `weather_info` table

| **컬럼명**                | **설명**                                                                                   |
|-------------------------|--------------------------------------------------------------------------------------------|
| `station_id`             | 기상 관측소의 고유 번호 (정수형)                                                               |
| `station_name`           | 기상 관측소의 이름 (문자열형, 최대 150자)                                                       |
| `record_time`            | 기상 데이터를 기록한 날짜 및 시간 (문자열형, 예: "2024-01-01")                                 |
| `avg_temperature`        | 해당 날짜의 평균 기온 (실수형, 섭씨 기준)                                                      |
| `max_temperatue`         | 해당 날짜의 최고 기온 (실수형, 섭씨 기준)                                                      |
| `max_temp_time`          | 최고 기온이 발생한 시간 (문자열형, 예: "12:44")                                                |
| `min_temperature`        | 해당 날짜의 최저 기온 (실수형, 섭씨 기준)                                                      |
| `min_temp_time`          | 최저 기온이 발생한 시간 (문자열형, 예: "07:59")                                                |
| `daily_temperature_range`| 해당 날짜의 일교차 (실수형, 최고 기온과 최저 기온의 차이, 섭씨 기준)                               |
| `id`                     | 각 데이터 레코드의 고유 식별자 (자동 증가하는 정수형)                                           |

## DDL
```
CREATE TABLE TemperatureData (
    id INT PRIMARY KEY AUTO_INCREMENT,     -- 아이디
    station_id INT NOT NULL,               -- 지점번호
    station_name VARCHAR(100) NOT NULL,    -- 지점명
    record_time DATETIME NOT NULL,         -- 일시
    avg_temperature FLOAT,                 -- 평균기온
    max_temperature FLOAT,                 -- 최고기온
    max_temp_time TIME,                    -- 최고기온시각
    min_temperature FLOAT,                 -- 최저기온
    min_temp_time TIME,                    -- 최저기온시각
    daily_temperature_range FLOAT,         -- 일교차
    PRIMARY KEY (id)
);
```

---

### 1. [dataSet]
기상청 자료개방포털에서 **제주도** 기온 데이터를 가져와 데이터 정제 후 사용

![image](https://github.com/user-attachments/assets/ea6825a1-9e71-439e-b963-584488d4a6e9)

![image](https://github.com/user-attachments/assets/8c218960-b4ab-4337-9186-2fb27335a147)





출처 : 기상청

[기상자료개방포털](https://data.kma.go.kr/cmmn/main.do)


### 2. [logstash] weather_info.conf
## logstash.conf 파일 설정
- jdbc driver 와 연동

```
input {
  jdbc {
    jdbc_driver_library => "C:\02.devEnv\ELK\logstash-7.11.1\lib\mysql-connector-j-8.0.33.jar" # JDBC 드라이버 경로
    jdbc_driver_class => "com.mysql.cj.jdbc.Driver" # MySQL JDBC 드라이버 클래스
    jdbc_connection_string => "jdbc:mysql://192.168.1.10:3306/fisa" # MySQL 연결 문자열
    jdbc_user => "user01" # MySQL 사용자
    jdbc_password => "user01" # MySQL 비밀번호
    statement => "SELECT * FROM weather_info WHERE id > :sql_last_value" # 실행할 SQL 쿼리
    use_column_value => true
    tracking_column => "id" # 쿼리에서 변경된 데이터 추적
    tracking_column_type => "numeric"
    last_run_metadata_path => "C:\00.dataSet\03.9997\.logstash_jdbc_last_run" # 마지막 실행 시간 저장 경로
    schedule => "* * * * *" # 매 분 실행
  }
}

output {
  elasticsearch {
    hosts => ["http://localhost:9200"] # Elasticsearch 호스트
    index => "weather_info_data" # Elasticsearch 인덱스 이름
  }

  stdout { codec => rubydebug } # 디버깅용 출력
}
```


### 3. weather_info
![image](https://github.com/user-attachments/assets/1c744053-ff82-49c6-b043-d3b8a49d5acc)


---

## 5. Practice course
### 5-1. 수집된 지역 별 기상 정보 데이터 합치기

- 메모장에서 데이터를 하나의 파일로 합치고 인코딩 UTF-8로 바꿔서 저장
- CSV파일 DBeaver로 Import하기

<img src="db.png" width="500"/>

- PK로 설정할 수 있는 컬럼이 없어서 Auto Increment를 사용하는 id 컬럼을 추가하여 PK로 설정

### 5-2. Logstash에서 JDBC 연동

- config 파일 

```javascript
input {
  jdbc {
    jdbc_driver_library => "C:\02.devEnv\ELK\logstash-7.11.1\lib\mysql-connector-j-8.0.33.jar" # JDBC 드라이버 경로
    jdbc_driver_class => "com.mysql.cj.jdbc.Driver" # MySQL JDBC 드라이버 클래스
    jdbc_connection_string => "jdbc:mysql://localhost:3306/fisa" # MySQL 연결 문자열
    jdbc_user => "user01" # MySQL 사용자
    jdbc_password => "user01" # MySQL 비밀번호
    statement => "SELECT * FROM weather_info WHERE id > :sql_last_value" # 실행할 SQL 쿼리
    use_column_value => true
    tracking_column => "id" # 쿼리에서 변경된 데이터 추적
    tracking_column_type => "numeric"
    last_run_metadata_path => "C:\00.dataSet\03.9997\.logstash_jdbc_last_run" # 마지막 실행 시간 저장 경로
    schedule => "* * * * *" # 매 분 실행
  }
}

output {
  elasticsearch {
    hosts => ["http://localhost:9200"] # Elasticsearch 호스트
    index => "weather_info_data" # Elasticsearch 인덱스 이름
  }

  stdout { codec => rubydebug } # 디버깅용 출력
}  
```

### 5-3. logstash 실행

- elastic search 실행 후 logstash 실행
```bash
logstash -f ..\config\weather_info.conf
```

- 정상적으로 SELECT를 하는지, 1분을 주기로 다시 SEELCT 하는지 확인

<img src="result.PNG" width="500"/>
<img src="head1.png" width="500"/>
<img src="head2.png" width="500"/>

- DB에 3개의 값을 추가하고 1분 후 중복되지 않은 값인 id값이 추가됨을 logstash에서 인식하고 2702개였던 데이터가 2705개로 정상적으로 추가됨

### 5-4. 

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

# AUTO_INCREMENT 오류

PRIMARY KEY 를 먼저 설정하지 않은채로 AUTO_INCREMENT 설정을 하여 오류발생.

![image](https://github.com/user-attachments/assets/f8dd66ce-6098-4293-9ca6-4911d919a46e)

PRIMARY KEY 를 먼저 설정하여 해결.

![image](https://github.com/user-attachments/assets/d063cf08-02f5-41b2-a61d-42f2c2266656)

## 7. Review
