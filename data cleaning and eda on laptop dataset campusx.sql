create database sql_projects;

use sql_projects;

select * from laptops;

-- CREATING THE BACKUP OF THE DATA
create table laptops_backup like laptops;

insert into laptops_backup
select * from laptops;

select * from laptops_backup;

-- CHECKING FOR THE MEMORY ALLOCATED FOR THIS DATA
select data_length/1024 from information_schema.tables
where table_schema = 'sql_projects'
and table_name = 'laptops';

select count(*) from laptops;

ALTER TABLE laptops 
rename column `Unnamed: 0` to `index`;


SET SQL_SAFE_UPDATES = 0;


# REMOVING ALL THE ROWS WHERE ALL THE COLUMNS VALUE are NULL

select distinct(company) from laptops;

SELECT DISTINCT company, LENGTH(company)
FROM laptops;

select count(*) from laptops where company = "";

DELETE FROM laptops 
WHERE `index` IN (
    SELECT * FROM (
        SELECT `index` 
        FROM laptops
        WHERE TRIM(Company) = "" 
        AND TRIM(TypeName) = "" 
        AND TRIM(Inches) = ""
        AND TRIM(ScreenResolution) = "" 
        AND TRIM(Cpu) = "" 
        AND TRIM(Ram) = ""
        AND TRIM(Memory) = "" 
        AND TRIM(Gpu) = "" 
        AND TRIM(OpSys) = ""
        AND TRIM(Weight) = "" 
        AND TRIM(Price) = ""
    ) AS temp
);

select * from laptops;

select count(*) from laptops;

DESCRIBE laptops;

select distinct(company)  from laptops;

select distinct(typename) from laptops;

select distinct(inches) from laptops;

SELECT `index` 
FROM laptops
WHERE inches NOT REGEXP '^[0-9.]+$';

update laptops set inches = null where inches NOT REGEXP '^[0-9.]+$';

ALTER TABLE laptops MODIFY COLUMN Inches DECIMAL(10,1);

select * from laptops;

update laptops set ram = replace(ram, "GB","");

ALTER TABLE laptops MODIFY COLUMN Ram INTEGER;

update laptops set weight = replace(weight,"kg","");


 SELECT * FROM laptops
WHERE weight NOT REGEXP '^[0-9.]+$';

update laptops set weight = null where weight NOT REGEXP '^[0-9.]+$';

ALTER TABLE laptops MODIFY COLUMN weight decimal(10,2);

update laptops set price = round(price);

ALTER TABLE laptops MODIFY COLUMN Price INTEGER;

select * from laptops;

SELECT DISTINCT OpSys FROM laptops;

select opsys,
case
    when opsys like '%mac%' then 'macOS'
    when opsys like '%windows%' then 'Windows'
    when opsys like '%Linux%' then 'Linux'
    when opsys like '%No OS%' then 'N/A'
    else 'Other'
end as 'OS Brand'
from laptops;

update laptops set opsys =
case
    when opsys like '%mac%' then 'macOS'
    when opsys like '%windows%' then 'Windows'
    when opsys like '%Linux%' then 'Linux'
    when opsys like '%No OS%' then 'N/A'
    else 'Other'
end;

select * from laptops;

ALTER TABLE laptops
ADD COLUMN gpu_brand VARCHAR(255) AFTER Gpu,
ADD COLUMN gpu_name VARCHAR(255) AFTER gpu_brand;

select gpu, substring_index(gpu,' ',1) from laptops;

update laptops set gpu_brand = substring_index(gpu,' ',1);

update laptops set gpu_name = replace(gpu,gpu_brand,"");


ALTER TABLE laptops DROP COLUMN Gpu;

SELECT * FROM laptops;

select count(*) from laptops;

ALTER TABLE laptops
ADD COLUMN cpu_brand VARCHAR(255) AFTER Cpu,
ADD COLUMN cpu_name VARCHAR(255) AFTER cpu_brand,
ADD COLUMN cpu_speed DECIMAL(10,1) AFTER cpu_name;

update laptops set cpu_brand = substring_index(cpu, ' ',1);

select cpu, substring_index(cpu, ' ',-1) from laptops;

update laptops set cpu_speed = replace(substring_index(cpu, ' ',-1),'GHz', '');

update laptops set cpu_name  = replace(replace(cpu,cpu_brand,''),substring_index(replace(cpu,cpu_brand,''),' ',-1),'');

alter table laptops drop column cpu;

select * from laptops;

ALTER TABLE laptops 
ADD COLUMN resolution_width INTEGER AFTER ScreenResolution,
ADD COLUMN resolution_height INTEGER AFTER resolution_width;

update laptops set resolution_height = substring_index(screenresolution,'x',-1);

update laptops set resolution_width = substring_index(substring_index(screenresolution,'x',1),' ',-1);

ALTER TABLE laptops 
ADD COLUMN touchscreen INTEGER AFTER resolution_height;

SELECT ScreenResolution LIKE '%Touch%' FROM laptops;

UPDATE laptops SET touchscreen = ScreenResolution LIKE '%Touch%';

SELECT * FROM laptops;

ALTER TABLE laptops DROP COLUMN ScreenResolution;

select distinct(cpu_name) from laptops;

select cpu_name, substring_index(trim(cpu_name),' ',2) from laptops;

update laptops set cpu_name = substring_index(trim(cpu_name),' ',2);

ALTER TABLE laptops
ADD COLUMN memory_type VARCHAR(255) AFTER Memory,
ADD COLUMN primary_storage INTEGER AFTER memory_type,
ADD COLUMN secondary_storage INTEGER AFTER primary_storage;


SELECT Memory,
CASE
	WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD%' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
    WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    ELSE NULL
END AS 'memory_type'
FROM laptops;

UPDATE laptops
SET memory_type = CASE
	WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD%' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
    WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    ELSE NULL
END;

SELECT Memory,
REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+'),
CASE WHEN Memory LIKE '%+%' THEN REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9]+') ELSE 0 END
FROM laptops;

UPDATE laptops
SET primary_storage = REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+'),
secondary_storage = CASE WHEN Memory LIKE '%+%' THEN REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9]+') ELSE 0 END;

select * from laptops;

SELECT 
primary_storage,
CASE WHEN primary_storage <= 2 THEN primary_storage*1024 ELSE primary_storage END,
secondary_storage,
CASE WHEN secondary_storage <= 2 THEN secondary_storage*1024 ELSE secondary_storage END
from laptops;

UPDATE laptops
SET primary_storage = CASE WHEN primary_storage <= 2 THEN primary_storage*1024 ELSE primary_storage END,
secondary_storage = CASE WHEN secondary_storage <= 2 THEN secondary_storage*1024 ELSE secondary_storage END;


SELECT * FROM laptops;

ALTER TABLE laptops DROP COLUMN memory;

SELECT * FROM laptops;
--  --------------------------------------------------   EDA  ------------------------------------------------------------------------------------


SELECT * FROM laptops;
SELECT * FROM laptops_backup;

-- HEAD, TAIL AND SAMPLE
SELECT * FROM laptops
ORDER BY `index` LIMIT 5;

SELECT * FROM laptops
ORDER BY `index` DESC LIMIT 5;

SELECT * FROM laptops
ORDER BY rand() LIMIT 5;


SELECT COUNT(Price) OVER(),
MIN(Price) OVER(),
MAX(Price) OVER(),
AVG(Price) OVER(),
STD(Price) OVER()
FROM laptops
ORDER BY `index` LIMIT 1;


-- CHEKING FOR PERCENTILE VALUES
DELIMITER //
CREATE PROCEDURE GetPriceByPercentile(
              IN percentileValue DECIMAL(3, 2), 
              OUT price_limit DECIMAL(10, 2))
       BEGIN
           SELECT Min(Price)
           INTO price_limit
              FROM (
                 SELECT DISTINCT price, ROUND(PERCENT_RANK() OVER (ORDER BY price), 2) AS percentile 
                 FROM laptops
                  ) AS k
            WHERE percentile >= percentileValue;
       END //
DELIMITER ;


CALL GetPriceByPercentile(0.25, @q1);
CALL GetPriceByPercentile(0.50, @q2);
CALL GetPriceByPercentile(0.75, @q3);

select @q1 as Q1,@q2 as Median , @q3 as Q3 ;   

-- CHECKING MISSING VALUES
SELECT COUNT(Price)
FROM laptops
WHERE Price IS NULL;

-- CHECKING OUTLIERS
SELECT * FROM laptops
WHERE price <  (@q1 - 1.5 * (@q3 - @q1))
   OR price >  (@q3 + 1.5 * (@q3 - @q1));  

SELECT t.buckets,REPEAT('*',COUNT(*)/5) FROM (SELECT price, 
CASE 
	WHEN price BETWEEN 0 AND 25000 THEN '0-25K'
    WHEN price BETWEEN 25001 AND 50000 THEN '25K-50K'
    WHEN price BETWEEN 50001 AND 75000 THEN '50K-75K'
    WHEN price BETWEEN 75001 AND 100000 THEN '75K-100K'
	ELSE '>100K'
END AS 'buckets'
FROM laptops) t
GROUP BY t.buckets;

SELECT Company,COUNT(Company) FROM laptops
GROUP BY Company;

SELECT cpu_speed,Price FROM laptops;

SELECT * FROM laptops;

SELECT Company,
SUM(CASE WHEN Touchscreen = 1 THEN 1 ELSE 0 END) AS 'Touchscreen_yes',
SUM(CASE WHEN Touchscreen = 0 THEN 1 ELSE 0 END) AS 'Touchscreen_no'
FROM laptops
GROUP BY Company;

SELECT DISTINCT cpu_brand FROM laptops;

SELECT Company,
SUM(CASE WHEN cpu_brand = 'Intel' THEN 1 ELSE 0 END) AS 'intel',
SUM(CASE WHEN cpu_brand = 'AMD' THEN 1 ELSE 0 END) AS 'amd',
SUM(CASE WHEN cpu_brand = 'Samsung' THEN 1 ELSE 0 END) AS 'samsung'
FROM laptops
GROUP BY Company;

-- Categorical Numerical Bivariate analysis
SELECT Company,MIN(price),
MAX(price),AVG(price),STD(price)
FROM laptops
GROUP BY Company;

-- Dealing with missing values
-- replace missing values with mean price of corresponding company
UPDATE laptops l1
SET price = (SELECT AVG(price) FROM laptops l2 WHERE
			 l2.Company = l1.Company)
WHERE price IS NULL;

SELECT * FROM laptops
WHERE price IS NULL;
-- corresponsing company + processor
SELECT * FROM laptops;


-- Feature Engineering
ALTER TABLE laptops ADD COLUMN ppi INTEGER;

UPDATE laptops
SET ppi = ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/Inches);

SELECT * FROM laptops
ORDER BY ppi DESC;

ALTER TABLE laptops ADD COLUMN screen_size VARCHAR(255) AFTER Inches;

UPDATE laptops
SET screen_size = 
CASE 
	WHEN Inches < 14.0 THEN 'small'
    WHEN Inches >= 14.0 AND Inches < 17.0 THEN 'medium'
	ELSE 'large'
END;

SELECT screen_size,AVG(price) FROM laptops
GROUP BY screen_size;

-- One Hot Encoding

SELECT gpu_brand,
CASE WHEN gpu_brand = 'Intel' THEN 1 ELSE 0 END AS 'intel',
CASE WHEN gpu_brand = 'AMD' THEN 1 ELSE 0 END AS 'amd',
CASE WHEN gpu_brand = 'nvidia' THEN 1 ELSE 0 END AS 'nvidia',
CASE WHEN gpu_brand = 'arm' THEN 1 ELSE 0 END AS 'arm'
FROM laptops



 



-- -----------------------------------------------------------  EDA  ---------------------------------------------------------------------------------------------------
SELECT * FROM laptops;

-- HEAD, TAIL AND SAMPLE
SELECT * FROM laptops
ORDER BY `index` LIMIT 5;

SELECT * FROM laptops
ORDER BY `index` DESC LIMIT 5;

SELECT * FROM laptops
ORDER BY rand() LIMIT 5;


SELECT COUNT(Price) OVER(),
MIN(Price) OVER(),
MAX(Price) OVER(),
AVG(Price) OVER(),
STD(Price) OVER()
FROM laptops
ORDER BY `index` LIMIT 1;

select company , count(price) from laptops group by company order by count(price) desc

-- CHEKING FOR PERCENTILE VALUES
DELIMITER //
CREATE PROCEDURE GetPriceByPercentile(
              IN percentileValue DECIMAL(3, 2), 
              OUT price_limit DECIMAL(10, 2))
       BEGIN
           SELECT Min(Price)
           INTO price_limit
              FROM (
                 SELECT DISTINCT price, ROUND(PERCENT_RANK() OVER (ORDER BY price), 2) AS percentile 
                 FROM laptops
                  ) AS k
            WHERE percentile >= percentileValue;
       END //
DELIMITER ;


CALL GetPriceByPercentile(0.25, @q1);
CALL GetPriceByPercentile(0.50, @q2);
CALL GetPriceByPercentile(0.75, @q3);

select @q1 as Q1,@q2 as Median , @q3 as Q3 ;   

-- CHECKING MISSING VALUES
SELECT COUNT(Price)
FROM laptops
WHERE Price IS NULL;

-- CHECKING OUTLIERS
SELECT * FROM laptops
WHERE price <  (@q1 - 1.5 * (@q3 - @q1))
   OR price >  (@q3 + 1.5 * (@q3 - @q1));  

SELECT t.buckets,REPEAT('*',COUNT(*)/5) FROM (SELECT price, 
CASE 
	WHEN price BETWEEN 0 AND 25000 THEN '0-25K'
    WHEN price BETWEEN 25001 AND 50000 THEN '25K-50K'
    WHEN price BETWEEN 50001 AND 75000 THEN '50K-75K'
    WHEN price BETWEEN 75001 AND 100000 THEN '75K-100K'
	ELSE '>100K'
END AS 'buckets'
FROM laptops) t
GROUP BY t.buckets;

SELECT Company,COUNT(Company) FROM laptops
GROUP BY Company;

SELECT cpu_speed,Price FROM laptops;

SELECT * FROM laptops;

SELECT Company,
SUM(CASE WHEN Touchscreen = 1 THEN 1 ELSE 0 END) AS 'Touchscreen_yes',
SUM(CASE WHEN Touchscreen = 0 THEN 1 ELSE 0 END) AS 'Touchscreen_no'
FROM laptops
GROUP BY Company;

SELECT DISTINCT cpu_brand FROM laptops;

SELECT Company,
SUM(CASE WHEN cpu_brand = 'Intel' THEN 1 ELSE 0 END) AS 'intel',
SUM(CASE WHEN cpu_brand = 'AMD' THEN 1 ELSE 0 END) AS 'amd',
SUM(CASE WHEN cpu_brand = 'Samsung' THEN 1 ELSE 0 END) AS 'samsung'
FROM laptops
GROUP BY Company;

-- Categorical Numerical Bivariate analysis
SELECT Company,MIN(price),
MAX(price),AVG(price),STD(price)
FROM laptops
GROUP BY Company;

-- Dealing with missing values
-- replace missing values with mean price of corresponding company
UPDATE laptops l1
SET price = (SELECT AVG(price) FROM laptops l2 WHERE
			 l2.Company = l1.Company)
WHERE price IS NULL;

SELECT * FROM laptops
WHERE price IS NULL;
-- corresponsing company + processor
SELECT * FROM laptops;


-- Feature Engineering
ALTER TABLE laptops ADD COLUMN ppi INTEGER;

UPDATE laptops
SET ppi = ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/Inches);

SELECT * FROM laptops
ORDER BY ppi DESC;

ALTER TABLE laptops ADD COLUMN screen_size VARCHAR(255) AFTER Inches;

UPDATE laptops
SET screen_size = 
CASE 
	WHEN Inches < 14.0 THEN 'small'
    WHEN Inches >= 14.0 AND Inches < 17.0 THEN 'medium'
	ELSE 'large'
END;

SELECT screen_size,AVG(price) FROM laptops
GROUP BY screen_size;

-- One Hot Encoding

SELECT gpu_brand,
CASE WHEN gpu_brand = 'Intel' THEN 1 ELSE 0 END AS 'intel',
CASE WHEN gpu_brand = 'AMD' THEN 1 ELSE 0 END AS 'amd',
CASE WHEN gpu_brand = 'nvidia' THEN 1 ELSE 0 END AS 'nvidia',
CASE WHEN gpu_brand = 'arm' THEN 1 ELSE 0 END AS 'arm'
FROM laptops



 
