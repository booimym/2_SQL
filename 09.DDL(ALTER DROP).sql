--DDL(Data Definition Language)
--객체를 만들고(CREATE),바꾸고(ALTER),)삭제(DROP)하는 데이터 정의 언어

/*ALTER(바꾸다,수정하다,변조하다)

-테이블에서 수정할 수 있는 것
1) 제약 조건(추가/삭제) - 기존에 있던 제약조건 변경은 안 됨
2) 컬럼(추가/수정/삭제)
3) 이름 변경(테이블 이름,제약조건명,컬럼명을 바꿀 수 있다)
*/

-------------------------------------------------------------------------------------------------------------------

--1. 제약 조건(추가,삭제)

-- [작성법]
-- 1) 추가 : ALTER TABLE 테이블명
--          ADD [CONSTRAINT 제약조건명] 제약조건(지정할 컬럼명)
--			REFERENCES 테이블명[(컬럼명)] <-FK인 경우임.

-- 2) 삭제 : ALTER TABLE 테이블명
--			DROP CONSTRAINT 제약조건명;

--------EX) (1) DEPARTMENT 테이블을 복사한다.(컬럼명,데이터타입,NOT NULL만 복사한다.)
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

--------EX) (2) DEPT_COPY의 DEPT_TITLE컬럼에 UNIQUE 추가

ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DEPT_COPY_TITLE UNIQUE (DEPT_TITLE);
--------EX) (3) DEPT_COPY의 DEPT_TITLE컬럼에 UNIQUE 삭제
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DEPT_COPY_TITLE;

-- ***DEPT_COPY의 DEPT_TITLE컬럼에 NOT NULL 제약조건 추가/삭제
ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DEPT_COPY_TITLE_NN NOT NULL (DEPT_TITLE);
--> <참고> NOT NULL 제약조건은
--  다른 제약조건과 성질이 좀 다르다.
--  새로운 조건객체가 생성되는 것이 아니라,
--   컬럼 자체의 성질 변경의 형태임. 컬럼 자체에 NULL 허용/비허용을 제어하는 성질 변경의 형태로 인식됨.
-- (다르게 작성해야 됨...)
-- MODIFY(수정하다) 구문을 사용해서 NULL을 제어
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE NOT NULL; -- DEPT_TITLE 컬럼을 NOT NULL로 수정한다는 뜻.

--NULL을 허용하고싶을 때
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE NULL;

------------------------------------------------------------------
--2. 컬럼(추가/수정/삭제)

--컬럼추가
--ALTER TABLE 테이블명 ADD(컬럼명 데이터타입 [DEFAULT '값']);
							--아무것도 안 들어갔을 때 디폴트값 뭐 정할지 적을 수 있다.

--컬럼 수정 (데이터타입만, DEFAULT값만, NULL허용/비허용 여부만 수정 가능)
--ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입; -->데이터 타입 변경
--ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT '값'; -->DEFAULT 값 변경
--ALTER TABLE 테이블명 MODIFY 컬럼명 NULL -->NULL 허용으로 변경할 때
--ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL -->NULL 비허용으로 변경할 때

--컬럼 삭제
--ALTER TABLE 테이블명 DROP(삭제할 컬럼명);
--ALTER TABLE 테이블명 DROP COLUMN 컬럼명;

--* 컬럼 삭제 시 주의사항 *
-- 테이블이란? 행과 열로 이루어진 DB에 가장 기본적인 객체임.
--			테이블에 데이터가 저장된다.

-- 테이블은 최소 1개 이상의 컬럼이 존재해야 되기 때문에 
-- 모든 컬럼을 다 삭제할 수는 없다.

-------------------------------------------------------------
---<연습>------------------------------------------------------
------------------------------------------------------------
-------------------------------------------------------------

SELECT * FROM DEPT_COPY;

--CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD(CNAME VARCHAR2(30));


--LNAME 컬럼 추가(기본값:'한국')
ALTER TABLE DEPT_COPY ADD(LNAME VARCHAR2(30) DEFAULT '한국');
-->컬럼이 생성되면서 DEFAULT값이 자동 삽입됨.

--D10 개발1팀을 추가해볼게
--INSERT INTO DEPT_COPY 
--VALUES ('D10','개발1팀','L1',DEFAULT,DEFAULT);
--에러:  ORA-12899: "KH_LSY"."DEPT_COPY"."DEPT_ID" 열에 대한 값이 너무 큼(실제: 3, 최대값: 2)
--왜냐면 DEPT_ID가 CHAR(2)라서 두글자밖에 못 넣음

--DEPT_ID 컬럼을 수정(가변적인 VARCHAR2로 수정하자~)
ALTER TABLE DEPT_COPY MODIFY DEPT_ID VARCHAR2(3);

INSERT INTO DEPT_COPY 
VALUES ('D10','개발1팀','L1',DEFAULT,DEFAULT);

--LNAME의 기본값을 'KOREA'로 수정하기
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT 'KOREA';
--> 기본값을 변경했다고 해서 기존 데이터가 변하지는 않는다.

--LNAME '한국' -> 'KOREA'로 변경
UPDATE DEPT_COPY SET LNAME = DEFAULT
WHERE LNAME = '한국';


COMMIT;

--모든 컬럼을 삭제해보기

ALTER TABLE DEPT_COPY  DROP(LNAME);
ALTER TABLE DEPT_COPY  DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY  DROP(LOCATION_ID);
ALTER TABLE DEPT_COPY  DROP(DEPT_TITLE);
ALTER TABLE DEPT_COPY  DROP(DEPT_ID);
-- ORA-12983: 테이블에 모든 열들을 삭제할 수 없습니다

--아예 테이블 삭제~
DROP TABLE DEPT_COPY;

--DEPARTMENT테이블을 복사해서 DEPT_COPY 다시 만들어볼게!

CREATE TABLE DEPT_COPY 
AS SELECT * FROM DEPARTMENT;
--> 컬럼명/데이터타입/NOT NULL여부만 복사가 된다.

-->DEPT_COPY 테이블에 PK제약조건을 추가하자(
--컬럼:DEPT_ID, 제약조건명: D_COPY_PK)

ALTER TABLE DEPT_COPY 
ADD CONSTRAINT D_COPY_PK PRIMARY KEY(DEPT_ID);

-------------------------------------------------------------
---<연습 끝>------------------------------------------------------
------------------------------------------------------------
-------------------------------------------------------------



--3. 이름 변경(컬럼명,제약조건명,테이블명)

--1) 컬럼명 변경(DEPT_TITLE -> DEPT_NAME)
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
SELECT* FROM DEPT_COPY;

--2) 제약조건명 변경(D_COPY_PK ->DEPT_COPY_PK)
ALTER TABLE DEPT_COPY RENAME CONSTRAINT D_COPY_PK TO DEPT_COPY_PK;

--3) 테이블명 변경(DEPT_COPY -> DCOPY)
ALTER TABLE DEPT_COPY RENAME TO DCOPY;

SELECT * FROM DCOPY;

-----------------------------------------------------------
--4. 테이블 삭제

--DROP TABLE 테이블명 [CASCADE CONSTRAINTS];

--1) 관계가 형성되지 않은 테이블(DCOPY) 삭제

DROP TABLE DCOPY;

--2) 관계가 형성된 테이블 삭제

CREATE TABLE TB1(
	TB1_PK NUMBER PRIMARY KEY,
	TB1_COL NUMBER 
	);

CREATE TABLE TB2(
	TB2_PK NUMBER PRIMARY KEY,
	TB2_COL NUMBER REFERENCES TB1
);

--TB1에 샘플 데이터 삽입
INSERT INTO TB1 VALUES(1,100);
INSERT INTO TB1 VALUES(2,200);
INSERT INTO TB1 VALUES(3,300);
COMMIT;

--TB2에 샘플 데이터 삽입
INSERT INTO TB2 VALUES(11,1);
INSERT INTO TB2 VALUES(22,2);
INSERT INTO TB2 VALUES(33,3);

--부모에게 작성된 값(1,2,3)이랑 NULL만 쓸 수 있어서 4는 오류난다.
--ORA-00001: 무결성 제약 조건(KH_LSY.SYS_C008397)에 위배됩니다
INSERT INTO TB1 VALUES(33,4);

--TB1삭제해보기
--에러) ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다
DROP TABLE TB1;
--[해결방법]
--1) 자식,부모 테이블 순서로 삭제(자식도 없어져야 된다는 문제가 있다.)
--2) ALTER를 이용해서 FK제약조건을 삭제 후에 TB1을 삭제한다( 두 번 해야 돼서 번거로움)
--3) DROP TABLE 삭제 옵션인 CASCADE CONSTRAINTS를 사용한다.(2번방법을 1줄로 줄여주는 방법임)
--	(FK제약조건과 TB1을 동시에 삭제하는 방법임.)

DROP TABLE TB1 CASCADE CONSTRAINTS;
-->삭제 성공

-----------------------------------------------------

/*     DDL 주의 사항 2가지       */

--1) DDL은 COMMIT,ROLLBACK이 안 된다.(수정,삭제를 신중하게 해야 된다...)
--2) DDL과 DML 구문을 섞어서 수행하면 안 된다.

SELECT* FROM TB2;
COMMIT;

INSERT INTO TB2 VALUES(44,4);
INSERT INTO TB2 VALUES(55,5);
INSERT INTO TB2 VALUES(66,6);

ALTER TABLE TB2 RENAME COLUMN TB2_COL TO TB2_COLCOL;

ROLLBACK;




