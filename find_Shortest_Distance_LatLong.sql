SELECT *,  Round(srs.Stdistance(tgt) / 1609, 0) AS miles 
FROM  (SELECT originlat,    originlong,    destlat,  destlong, 
              Cast ('POINT(' + Cast(originlong AS NVARCHAR(255)) + ' '  + Cast(originlat AS NVARCHAR(255)) + ')' AS GEOGRAPHY) AS srs, 
              Cast ('POINT(' + Cast(destlong AS NVARCHAR(255))  + ' ' + Cast(destlat AS NVARCHAR(255)) + ')' AS GEOGRAPHY) AS tgt 
       FROM   OPENROWSET('Microsoft.ACE.OLEDB.12.0',  'Excel 12.0; Database=C:\\Excel_Files\\REF_Dummy_excel_file.xlsx', [Sheet1$])
)a   
