
-- This would allow us to set a variable within the CTE
SET GLOBAL log_bin_trust_function_creators = 1;


USE FriendFinder_DB;

DELIMITER //

CREATE FUNCTION GetBestFriendMatch (current_friend INT)
RETURNS INT
BEGIN

    DECLARE current_id INT DEFAULT 0;
	DECLARE close_match_id INT DEFAULT 0;

	SET current_id = current_friend;
    
    -- CREATE TEMPORARY TABLE new_tbl;
    
    WITH CTE1(CTE_ID) AS (
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question1 = A.question1
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE2(CTE_ID) AS(
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question2 = A.question2
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE3(CTE_ID) AS(
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question3 = A.question3
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE4(CTE_ID) AS(
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question4 = A.question4
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE5(CTE_ID) AS(
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question5 = A.question5
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE6(CTE_ID) AS(
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question6 = A.question6
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE7(CTE_ID) AS(
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question7 = A.question7
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE8(CTE_ID) AS(
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question8 = A.question8
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE9(CTE_ID) AS(
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question9 = A.question9
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE10(CTE_ID) AS(
        SELECT A.ID CTE_ID
        FROM friendFinder A
        JOIN friendFinder B 
            ON B.question10 = A.question10
            AND B.id = current_id
        WHERE A.id <> current_id
    )
    , CTE_AGGREGATE (CTE_ID, CNT) AS (
        SELECT CTE_ID, 1 CNT FROM CTE1
        UNION ALL
        SELECT CTE_ID, 1 CNT FROM CTE2
        UNION ALL
        SELECT CTE_ID, 1 CNT FROM CTE3
        UNION ALL
        SELECT CTE_ID, 1 CNT FROM CTE4
        UNION ALL
        SELECT CTE_ID, 1 CNT FROM CTE5
        UNION ALL
        SELECT CTE_ID, 1 CNT FROM CTE6
        UNION ALL
        SELECT CTE_ID, 1 CNT FROM CTE7
        UNION ALL
        SELECT CTE_ID, 1 CNT FROM CTE8
        UNION ALL
        SELECT CTE_ID, 1 CNT FROM CTE9
        UNION ALL
        SELECT CTE_ID, 1 CNT FROM CTE10
    )
    , FINAL_CNT (CTE_ID, SUM_CNT) AS (
        SELECT 
            CTE_ID, SUM(CNT) SUM_CNT
        FROM CTE_AGGREGATE
        GROUP BY CTE_ID
        ORDER BY SUM(CNT) DESC
    )
    SELECT 
		CTE_ID INTO close_match_id 
	FROM FINAL_CNT
    ORDER BY SUM_CNT DESC
	LIMIT 1;
    

    RETURN close_match_id;

END; //

DELIMITER ;










