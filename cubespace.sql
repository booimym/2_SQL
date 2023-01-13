SELECT DISTINCT MEMBER_NO,MEMBER_NICKNAME,PROFILE_IMG, FRIEND_ACCEPT_FL, ASKING_MEMBER_NO 
FROM "MEMBER"
LEFT JOIN
(SELECT ASKED_MEMBER_NO MEMBER_NO, ASKING_MEMBER_NO, FRIEND_ACCEPT_FL FROM FRIEND WHERE ASKING_MEMBER_NO = 3
UNION
SELECT ASKING_MEMBER_NO MEMBER_NO, ASKING_MEMBER_NO, FRIEND_ACCEPT_FL FROM FRIEND WHERE ASKED_MEMBER_NO = 3)
USING (MEMBER_NO)
--WHERE MEMBER_NICKNAME LIKE '%이%'
ORDER BY MEMBER_NO;

SELECT * FROM EMOJI_IMG;

/*insert한 애들...*/
--INSERT INTO EMOJI_IMG VALUES(1,'/resources/images/diary/like.png');
--INSERT INTO EMOJI_IMG VALUES(2,'/resources/images/diary/heart.png');
--INSERT INTO EMOJI_IMG VALUES(3,'/resources/images/diary/smile.png');
--INSERT INTO EMOJI_IMG VALUES(4,'/resources/images/diary/tears.png');
--INSERT INTO EMOJI_IMG VALUES(5,'/resources/images/diary/cursing.png');
--INSERT INTO EMOJI_IMG VALUES(6,'/resources/images/diary/humm.png');

SELECT * FROM DIARY;
SELECT * FROM MEMBER;
SELECT DIARY_NO , MEMBER_NO , D_TITLE,D_CONTENT,D_CREATE,D_OPEN_FL,FOLDER_NO
FROM DIARY;
SELECT * FROM MEMBER_COMPLAIN;

SELECT * FROM FRIEND;

/*1번과 깐부관계인 멤버 조회*/
SELECT  MEMBER_NO, MEMBER_NICKNAME,BIRTHDAY
FROM FRIEND 
JOIN MEMBER ON (MEMBER_NO = ASKED_MEMBER_NO)
WHERE FRIEND_ACCEPT_FL = 1
AND ASKING_MEMBER_NO = 1
UNION 
SELECT  MEMBER_NO, MEMBER_NICKNAME,BIRTHDAY
FROM FRIEND 
JOIN MEMBER ON (MEMBER_NO = ASKING_MEMBER_NO)
WHERE FRIEND_ACCEPT_FL = 1
AND ASKED_MEMBER_NO = 1

SELECT FRIEND_NO, MEMBER_NICKNAME , PROFILE_IMG FROM
			(SELECT ASKED_MEMBER_NO FRIEND_NO, MEMBER_NICKNAME, PROFILE_IMG
			FROM friend 
			JOIN MEMBER ON(ASKED_MEMBER_NO = MEMBER_NO)
			WHERE ASKING_MEMBER_NO = #{memberNo} AND FRIEND_ACCEPT_FL = 1 AND MEMBER_NICKNAME LIKE '%${searchInput}%')
		UNION
			(SELECT ASKING_MEMBER_NO FRIEND_NO, MEMBER_NICKNAME , PROFILE_IMG
			FROM friend 
			JOIN MEMBER ON(ASKING_MEMBER_NO = MEMBER_NO)
			WHERE ASKED_MEMBER_NO = #{memberNo} AND FRIEND_ACCEPT_FL = 1 AND MEMBER_NICKNAME LIKE '%${searchInput}%')
		ORDER BY MEMBER_NICKNAME


--다이어리에 샘플데이터 추가

--INSERT INTO DIARY VALUES (SEQ_DIARY_NO.NEXTVAL, 1, '올해의 마지막 일기2','올해가 30분 남았다...',DEFAULT,DEFAULT,1,1);
--INSERT INTO DIARY VALUES (SEQ_DIARY_NO.NEXTVAL, 1, '올해의 마지막 일기3','올해가 31분 남았다...',DEFAULT,DEFAULT,1,1);
INSERT INTO DIARY VALUES (SEQ_DIARY_NO.NEXTVAL, 1, '올해의 마지막 일기3','올해가 31분 남았다...',
TO_DATE('2023-01-01 13:00:00','YYYY-MM-DD HH24:MI:SS'),DEFAULT,1,1);

UPDATE DIARY SET D_CREATE = TO_DATE('2023-01-01 14:00:00','YYYY-MM-DD HH24:MI:SS')
WHERE DIARY_NO = 55;

commit


SELECT * FROM EMOJI;

/*PK 복합키로 변경함.*/
ALTER TABLE CUBESPACE.EMOJI DROP CONSTRAINT PK_EMOJI;
ALTER TABLE EMOJI 
ADD CONSTRAINT PK_DIARY_MEMBER_NO PRIMARY KEY (DIARY_NO, MEMBER_NO);

--INSERT INTO EMOJI VALUES (35,6,1);
--INSERT INTO EMOJI VALUES (35,10,2);
--INSERT INTO EMOJI VALUES (35,11,1);
--INSERT INTO EMOJI VALUES (35,12,3);
--INSERT INTO EMOJI VALUES (35,13,4);
--INSERT INTO EMOJI VALUES (25,8,5);
--INSERT INTO EMOJI VALUES (25,9,1);
--INSERT INTO EMOJI VALUES (25,10,1);
--INSERT INTO EMOJI VALUES (25,11,1);
--
--INSERT INTO EMOJI VALUES (26,2,2);
--INSERT INTO EMOJI VALUES (26,3,2);
--INSERT INTO EMOJI VALUES (26,5,1);
--INSERT INTO EMOJI VALUES (26,6,3);
--INSERT INTO EMOJI VALUES (26,7,4);
--INSERT INTO EMOJI VALUES (26,8,5);
--INSERT INTO EMOJI VALUES (26,9,2);
--INSERT INTO EMOJI VALUES (38,10,4);
--INSERT INTO EMOJI VALUES (38,2,4);
--INSERT INTO EMOJI VALUES (38,3,4);
--INSERT INTO EMOJI VALUES (38,4,4);
--INSERT INTO EMOJI VALUES (38,5,4);
--INSERT INTO EMOJI VALUES (39,10,4);
--INSERT INTO EMOJI VALUES (39,2,4);
--INSERT INTO EMOJI VALUES (39,3,4);
--INSERT INTO EMOJI VALUES (39,4,4);
--INSERT INTO EMOJI VALUES (39,5,4);

SELECT * FROM MEMBER;
SELECT * FROM EMOJI;
SELECT * FROM EMOJI_IMG;


/* ******************************************************************************************* */

/*loginMemberNo 와 미니홈피주인No가 깐부관계인지 확인하기.*/
SELECT COUNT(*) FROM (
SELECT * FROM FRIEND
WHERE (ASKED_MEMBER_NO = 1 AND ASKING_MEMBER_NO = 6)
OR (ASKED_MEMBER_NO = 6 AND ASKING_MEMBER_NO = 1)
AND FRIEND_ACCEPT_FL = 1);

/*다이어리 목록 조회하기 : 작성자 : 미니홈피 주인(이슬이) & 날짜 & 폴더 & 삭제되지 않은 글*/
SELECT * FROM DIARY;

SELECT DIARY_NO, D_TITLE, D_CONTENT, D_CREATE,TO_CHAR(D_CREATE,'AM HH24"시 "MI"분"') D_CREATE, D_OPEN_FL, FOLDER_NO  
FROM DIARY
WHERE MEMBER_NO = 1 
--AND TO_CHAR (D_CREATE,'YYYY-MM-DD') = '2022-12-23'
AND FOLDER_NO = 173
AND D_DEL_YN  = 'N'
AND (D_OPEN_FL = 1 OR D_OPEN_FL  = 2)
ORDER BY DIARY_NO DESC;

SELECT * FROM DIARY;
SELECT DIARY_NO, D_TITLE, D_CONTENT, D_CREATE,TO_CHAR(D_CREATE,'AM HH24"시 "MI"분"') D_CREATE, D_OPEN_FL, FOLDER_NO  
FROM DIARY
WHERE MEMBER_NO = 1 
AND FOLDER_NO = 1
AND D_DEL_YN  = 'N'
AND (D_OPEN_FL = 1 OR D_OPEN_FL  = 2);

COMMIT;

/*각 게시글에 있는 공감 목록 조회하기 */

/*(1) 받은 공감 개수별로 공감목록 조회하기 : 이건 뭐... 버튼 누를 때마다 새로 조회해주는 게 빠른... 그 목록*/
SELECT DIARY_NO, COUNT(*) EMOJI_COUNT, E.EMOJI_NO, EMOJI_PATH
FROM EMOJI E
JOIN EMOJI_IMG I ON (E.EMOJI_NO = I.EMOJI_NO)
WHERE DIARY_NO = 173
GROUP BY DIARY_NO, E.EMOJI_NO, EMOJI_PATH
ORDER BY EMOJI_COUNT DESC, EMOJI_NO ;
SELECT * FROM EMOJI;

SELECT * FROM EMOJI;
COMMIT;

SELECT * FROM DIARY ORDER BY 1 DESC;
/*공감을 누른 사람 목록*/
SELECT MEMBER_NICKNAME, PROFILE_IMG
FROM EMOJI E
JOIN EMOJI_IMG I ON (E.EMOJI_NO = I.EMOJI_NO)
JOIN MEMBER M ON (M.MEMBER_NO = E.MEMBER_NO)
WHERE DIARY_NO = 24 AND E.EMOJI_NO = 3;

/**************************************************************************************/
SELECT * FROM PLAN;
COMMIT;
/*full-calendar*/
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2022-12-07',NULL,'이슬이의 맥주파티');
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2022-12-08',NULL,'이슬이의 과자파티');
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2023-01-11',NULL,'파이널 마감일');
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2023-11-11',NULL,'이슬이가 빼빼로 먹는 날',1);
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2023-01-01','2023-01-02','이슬이의 1박 2일 엠티',1,'Y');
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2022-12-01','2022-12-03','여러날인데 시간있음',1,'N');
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2022-12-04','2022-12-07','여러날인데 allday',1,'Y');
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2022-12-11','2022-12-12','1박 2일인데 시간있음',1,'N');
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2022-12-18','2022-12-18','하루인데 끝나는시간다름',1,'N');
--INSERT INTO PLAN 
--VALUES (SEQ_PLAN_NO.NEXTVAL,1,'2022-12-20','2022-12-20','하루인데 ALLDAY',1,'Y');

--이 enddate처리는 뭐지? 일단 주석처리 해놓음
--SELECT START_DATE,
--	CASE 
--		WHEN PLAN_ALLDAY_FL = 'Y' THEN END_DATE
--		ELSE END_DATE
--	END AS END_DATE,
--PLAN_TITLE , PLAN_CATEGORY, PLAN_ALLDAY_FL,PLAN_DESCRIPTION,
--	CASE	
--		WHEN PLAN_CATEGORY = 1 THEN '#E0FFFF'
--		WHEN PLAN_CATEGORY = 2 THEN '#E6E6FA'
--		WHEN PLAN_CATEGORY = 3 THEN '#FFF0F5'
--		ELSE '#000000'
--	END AS COLOR
--FROM PLAN 
--WHERE MEMBER_NO = 1;

--spring에 올라간 거
SELECT START_DATE,
	NVL(END_DATE,START_DATE) END_DATE,
PLAN_TITLE , PLAN_CATEGORY, PLAN_ALLDAY_FL,PLAN_DESCRIPTION,
	CASE	
		WHEN PLAN_CATEGORY = 1 THEN '#C0EEE4'
		WHEN PLAN_CATEGORY = 2 THEN '#F8F988'
		WHEN PLAN_CATEGORY = 3 THEN '#D8F8B7'
		ELSE '#FFCAC8'
	END AS COLOR
FROM PLAN 
WHERE MEMBER_NO = 1;

SELECT * FROM FOLDER WHERE BOARD_TYPE_NO = 1
AND MEMBER_NO = 1;

SELECT * FROM DIARY;

SELECT * FROM PLAN;

SELECT DISTINCT TO_NUMBER(TO_CHAR(D_CREATE, 'DD')) YEAR_MONTH 
FROM DIARY 
WHERE TO_CHAR(D_CREATE, 'YYYY-MM') = '2023-01' ORDER BY 1;

SELECT * FROM DIARY;

SELECT * FROM FOLDER WHERE MEMBER_NO =1 AND BOARD_TYPE_NO =1;
COMMIT;

DELETE FROM PLAN WHERE PLAN_NO = 168;
DELETE FROM DIARY WHERE DIARY_NO BETWEEN 183 AND 192;

SELECT * FROM PLAN;
SELECT * FROM FOLDER;
SELECT * FROM EMOJI;

SELECT DIARY_NO, MEMBER_NO, (SELECT COUNT(*)
FROM EMOJI 
WHERE DIARY_NO = 24 ) FROM EMOJI;


SELECT MEMBER_NO, EMOJI_NO
FROM EMOJI
WHERE DIARY_NO = 24 ;

SELECT DIARY_NO, COUNT(*) EMOJI_COUNT, E.EMOJI_NO, EMOJI_PATH
FROM EMOJI E
JOIN EMOJI_IMG I ON (E.EMOJI_NO = I.EMOJI_NO)
WHERE DIARY_NO = 24
GROUP BY DIARY_NO, E.EMOJI_NO, EMOJI_PATH


--------------------------------------------------------------------------------------
SELECT * FROM FONT_SHOP;

/*효동*/
SELECT FONT_NO, FONT_NAME ,FONT_PATH ,FONT_CREATER , NVL(COUNT_NO,0) COUNT_NO ,
	CASE
	WHEN FONT_NO IN (SELECT GOODS_NO 
	FROM MEMBER_OWN_GOODS
	WHERE MEMBER_NO = 2 AND SHOP_CATH_NO = 1) THEN FONT_NO
	ELSE NULL 
	END AS HIHI
FROM FONT_SHOP F
LEFT JOIN (
	SELECT COUNT(*) COUNT_NO, GOODS_NO
	FROM MEMBER_OWN_GOODS
	WHERE SHOP_CATH_NO = 1
	GROUP BY GOODS_NO
	ORDER BY COUNT_NO DESC
) S ON (F.FONT_NO = S.GOODS_NO)
ORDER BY FONT_NO DESC;

/*효동 - 최신순 3개*/
SELECT * FROM (
SELECT FONT_NO, FONT_NAME ,FONT_PATH ,FONT_CREATER , NVL(COUNT_NO,0) COUNT_NO ,
	CASE
	WHEN FONT_NO IN (SELECT GOODS_NO 
	FROM MEMBER_OWN_GOODS
	WHERE MEMBER_NO = 2 AND SHOP_CATH_NO = 1) THEN FONT_NO
	ELSE NULL 
	END AS HIHI
FROM FONT_SHOP F
LEFT JOIN (
	SELECT COUNT(*) COUNT_NO, GOODS_NO
	FROM MEMBER_OWN_GOODS
	WHERE SHOP_CATH_NO = 1
	GROUP BY GOODS_NO
	ORDER BY COUNT_NO DESC
) S ON (F.FONT_NO = S.GOODS_NO)
ORDER BY FONT_NO DESC) 
WHERE ROWNUM <= 3;

SELECT * FROM (
SELECT FONT_NO, FONT_NAME ,FONT_PATH ,FONT_CREATER , NVL(COUNT_NO,0) FONT_COUNT_NO , SHOP_CATH_NO,
   CASE
   WHEN FONT_NO IN (SELECT GOODS_NO 
   FROM MEMBER_OWN_GOODS
   WHERE MEMBER_NO = 1 AND SHOP_CATH_NO = 1) THEN FONT_NO
   ELSE 0 
   END AS GOODS_NO
FROM FONT_SHOP F
LEFT JOIN (
   SELECT COUNT(*) COUNT_NO, GOODS_NO , SHOP_CATH_NO
   FROM MEMBER_OWN_GOODS
   WHERE SHOP_CATH_NO = 1
   GROUP BY GOODS_NO,SHOP_CATH_NO
   ORDER BY COUNT_NO DESC
) S ON (F.FONT_NO = S.GOODS_NO)
ORDER BY FONT_NO DESC) 
WHERE ROWNUM <= 3;

SELECT * FROM MEMBER_OWN_GOODS; 
--------------------------------------------------------------------------------------
SELECT * FROM FOLDER WHERE MEMBER_NO = 1;

/*자기글에 공감 못남기게 하게 조회조건 걸음(샘플데이터 넣기용)*/
SELECT * FROM EMOJI
WHERE DIARY_NO IN(SELECT DIARY_NO FROM DIARY WHERE MEMBER_NO = 1);

SELECT *
FROM DIARY 
WHERE MEMBER_NO = 1 AND D_DEL_YN = 'N'; 

--169 2, 3
--173 2, 3, 46
--193 2

INSERT INTO EMOJI VALUES (199,39,2); 
INSERT INTO EMOJI VALUES (199,40,2); 
INSERT INTO EMOJI VALUES (199,41,2); 
--INSERT INTO EMOJI VALUES19973,46,3); 
INSERT INTO EMOJI VALUES (199,47,4); 
INSERT INTO EMOJI VALUES (199,50,6);  
INSERT INTO EMOJI VALUES (199,51,2); 
INSERT INTO EMOJI VALUES (199,52,3); 
INSERT INTO EMOJI VALUES (199,53,3); 
INSERT INTO EMOJI VALUES (199,54,3); 
INSERT INTO EMOJI VALUES (199,14,5); 
INSERT INTO EMOJI VALUES (199,15,1); 
INSERT INTO EMOJI VALUES (199,16,2); 
INSERT INTO EMOJI VALUES (199,17,3); 
INSERT INTO EMOJI VALUES (199,18,4); 
INSERT INTO EMOJI VALUES (199,19,5); 
INSERT INTO EMOJI VALUES (199,20,6); 
COMMIT;
SELECT * FROM EMOJI;
SELECT * FROM DIARY;
SELECT * FROM ALBUM;
SELECT * FROM plan;
SELECT * FROM MEMBER;

COMMIT;

SELECT * FROM EMOJI;
--DELETE FROM EMOJI;
--DELETE FROM DIARY;

ALTER TABLE DIARY DROP COLUMN D_CONTENT;
COMMIT;
ALTER TABLE DIARY MODIFY D_CONTENT CLOB;

ALTER TABLE DIARY ADD D_CONTENT CLOB NOT NULL;



-- 컬럼 순서 변경

ALTER TABLE DIARY MODIFY D_CREATE INVISIBLE;
ALTER TABLE DIARY MODIFY D_DEL_YN INVISIBLE;
ALTER TABLE DIARY MODIFY D_OPEN_FL INVISIBLE;
ALTER TABLE DIARY MODIFY FOLDER_NO INVISIBLE;

ALTER TABLE DIARY MODIFY D_CREATE INVISIBLE;

ALTER TABLE DIARY MODIFY D_CREATE  VISIBLE;
ALTER TABLE DIARY MODIFY D_DEL_YN  VISIBLE;
ALTER TABLE DIARY MODIFY D_OPEN_FL VISIBLE;
ALTER TABLE DIARY MODIFY FOLDER_NO VISIBLE;
---------------------------------------------
SELECT * FROM PLAN;
INSERT INTO PLAN VALUES(SEQ_PLAN_NO.NEXTVAL, )