CREATE OR REPLACE STREAM
"LIFE_SUPPORT_READINGS_COUNT" (
      "Room" VARCHAR(4)
    , "Total_Readings" INTEGER
    , "Minute_Bin" TIMESTAMP
)
;

CREATE OR REPLACE PUMP
    "STREAM_PUMP" AS
      INSERT INTO "LIFE_SUPPORT_READINGS_COUNT"
           SELECT STREAM "Name" as Room
                , COUNT(*) as Total_Readings
                , FLOOR(SOURCE_SQL_STREAM_001.ROWTIME TO MINUTE) AS Minute_Bin
             FROM "SOURCE_SQL_STREAM_001"
         GROUP BY FLOOR(SOURCE_SQL_STREAM_001.ROWTIME TO MINUTE)
                , "Name"
;