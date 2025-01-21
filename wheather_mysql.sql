CREATE TABLE test (
		id INT PRIMARY KEY AUTO_INCREMENT,     -- 아이디
    station_id INT NOT NULL,               -- 지점번호
    station_name VARCHAR(100) NOT NULL,    -- 지점명
    record_time DATETIME NOT NULL,         -- 일시
    avg_temperature FLOAT,                 -- 평균기온
    max_temperature FLOAT,                 -- 최고기온
    max_temp_time TIME,                    -- 최고기온시각
    min_temperature FLOAT,                 -- 최저기온
    min_temp_time TIME,                    -- 최저기온시각
    daily_temperature_range FLOAT         -- 일교차
);

CREATE TABLE test2 (
		id INT  AUTO_INCREMENT PRIMARY KEY,    -- 아이디
    station_id INT NOT NULL,               -- 지점번호
    station_name VARCHAR(100) NOT NULL,    -- 지점명
    record_time DATETIME NOT NULL,         -- 일시
    avg_temperature FLOAT,                 -- 평균기온
    max_temperature FLOAT,                 -- 최고기온
    max_temp_time TIME,                    -- 최고기온시각
    min_temperature FLOAT,                 -- 최저기온
    min_temp_time TIME,                    -- 최저기온시각
    daily_temperature_range FLOAT         -- 일교차
);

SET @row_num = 0;

UPDATE weather_info
SET id = (@row_num := @row_num + 1);

ALTER TABLE weather_info
ADD PRIMARY KEY (id);

ALTER TABLE weather_info
MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;


INSERT INTO weather_info (
	station_id,
	station_name,
	record_time,
	avg_temperature,
	max_temperatue,
	max_temp_time,
	min_temperature,
	min_temp_time,
	daily_temperature_range
)
VALUES
(189, '서귀포', '2024-01-26', 4.5, 7.3, '13:11', 2.6, '05:29', 4.7),
(189, '서귀포', '2024-01-27', 8.0, 11.2, '14:22', 5.4, '10:01', 5.8),
(189, '서귀포', '2024-01-28', 6.8, 9.5, '16:09', 4.1, '02:15', 5.4);