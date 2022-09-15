/*


 	DCL (Data Control Language) : 데이터를 다루기 위한 권한을 다루는 언어 
 	
 	- 계정에 DB, DB 객체에 대한 접근 권한을 부여하고(GRANT) 회수(REVOKE)하는 언어
 	
	 	* 권한의 종류
	
		1) 시스템 권한 : DB접속, 객체 생성 권한
		
		CRETAE SESSION   : 데이터베이스 접속 권한
		CREATE TABLE     : 테이블 생성 권한
		CREATE VIEW      : 뷰 생성 권한
		CREATE SEQUENCE  : 시퀀스 생성 권한
		CREATE PROCEDURE : 함수(프로시져) 생성 권한
		CREATE USER      : 사용자(계정) 생성 권한
		DROP USER        : 사용자(계정) 삭제 권한
		DROP ANY TABLE   : 임의 테이블 삭제 권한
	
	
		2) 객체 권한 : 특정 객체를 조작할 수 있는 권한
		
		  	권한 종류                 설정 객체
		    SELECT              TABLE, VIEW, SEQUENCE
		    INSERT              TABLE, VIEW
		    UPDATE              TABLE, VIEW
		    DELETE              TABLE, VIEW
		    ALTER               TABLE, SEQUENCE
		    REFERENCES          TABLE
		    INDEX               TABLE
		    EXECUTE             PROCEDURE

*/


/* USER - 계정(사용자)

* 관리자 계정 : 데이터베이스의 생성과 관리를 담당하는 계정.
                모든 권한과 책임을 가지는 계정.
                ex) sys(최고관리자), system(sys에서 권한 몇개 제외된 관리자)


* 사용자 계정 : 데이터베이스에 대하여 질의, 갱신, 보고서 작성 등의
                작업을 수행할 수 있는 계정으로
                업무에 필요한 최소한의 권한만을 가지는 것을 원칙으로 한다.
                ex) bdh계정(각자 이니셜 계정), updown, workbook 등
*/


--1. (SYS)계정으로/ 사용자 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; --예전 SQL방식을 허용한다는 뜻
										--계정명을 간단히 작성 가능할 수 있다.

--[작성법]
--CREATE USER 사용자명 IDENTIFIED BY 비밀번호;
--CREATE는 객체를 생성하는 것을 의미하는데, 즉 USER(사용자)도 객체다.

CREATE USER lsy_sample IDENTIFIED BY sample1234;

--2. 새 연결 (접속방법) 추가
--> ORA-01045 : CREATE SESSION 권한이 없어서 로그인 실패
				--CREATE SESSION : 접속 권한을 의미함.

--3.(SYS)계정으로/ 접속 권한 부여

--[권한 부여 작성법]
-- GRANT 권한,권한,권한,권한... TO 사용자명;
GRANT CREATE SESSION TO lsy_sample;

--4. 다시 연결(접속방법) 추가 -> 성공!

--5. (sample)계정으로/ 테이블 생성하기~

CREATE TABLE TB_TEST(
	PK_COL NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(100)
);
--ORA-01031: 권한이 불충분합니다 (테이블 생성권한이 없음...)
--  + 데이터를 저장할 수 있는 공간(TABLESPACE)도 할당을 같이 해주자!

-- 집 지을 공간 , 집 지을 수 있는 권한


--6. (SYS)계정으로/ 테이블 생성 권한 + TABLESPACE 할당하기

GRANT CREATE TABLE TO lsy_sample; -- 공간이 

ALTER USER lsy_sample DEFAULT TABLESPACE
SYSTEM QUOTA UNLIMITED ON SYSTEM; --시스템 안에서 무제한으로 TABLESPACE를 활용할 공간을 주겠다.

--7.  다시 (sample)계정으로/ 테이블 생성하기~

CREATE TABLE TB_TEST(
	PK_COL NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(100)
);

--------------------------------------------------------------

--ROLE(역할) : 권한의 묶음
--> 묶어둔 권한(ROLE)을 특정 계정에 부여하면, 
--   해당 계정은 지정된 권한을 이용해서 특정 역할을 갖게 된다.

--(SYS)계정으로/ sample 계정에 CONNECT, RESOURCE 권한을 부여해볼게!

GRANT CONNECT, RESOURCE TO lsy_sample;

--CONNECT  : DB 접속 관련 권한을 묶어둔 ROLE입니다.
--RESOURCE : DB 사용을 위한 기본 객체 생성 권한을 묶어돈 ROLE입니다.


---------------------------------------------------------------

-- *객체 권한 *

--kh_lsy / lsy_sample 사용자 계정끼리 서로 [객체 접근 권한]을 부여
--관리자가 하는 게 아니라 사용자끼리 하는 거임.

--1. (sample)계정으로/ kh_lsy 계정의 EMPLOYEE 테이블을 조회해보자
SELECT * FROM kh_lsy.EMPLOYEE;
--권한이 없으니까 (ORA-00942: 테이블 또는 뷰가 존재하지 않습니다)에러가 뜬다.

--2. (kh_lsy)계정으로/ kh_sample 계정에 EMPLOYEE 조회 권한을 부여해볼게!

--[객체 권한 부여 작성법]
--GRANT 객체권한 ON 객체명 TO 사용자명
GRANT SELECT ON EMPLOYEE TO lsy_sample;

--3. 다시 해보면 됨!

-------------------------
--KH계정 (운영용 DB)
--SAMPLE 계정(테스트 DB)
--운영용 DB의 데이터를 복사 후 테스트

--4. (sample)계정으로/ kh_lsy.EMPLOYEE 테이블을 복사한 테이블 생성
CREATE TABLE EMP_SAMPLE
AS SELECT * FROM  kh_lsy.EMPLOYEE;
--복사본이니까 원본에 영향이 없습니다.

--5. (kh_lsy)계정으로/ sample 계정에 부여한 EMPLOYEE 테이블 조회 권한을 회수(REVOKE)

--[권한 회수 작성법]
--REVOKE 객체 권한 ON 객체명 FROM 사용자명;

REVOKE SELECT ON EMPLOYEE FROM lsy_sample;
			--EMPLOYEE라는 테이블객체에 대한 권한을 뺏겠다.

--6.(sample)계정으로/확인해보기
SELECT * FROM kh_lsy.EMPLOYEE;
--ORA-00942: 테이블 또는 뷰가 존재하지 않습니다/에러뜨는 걸 보니 권한 뺏김.
















































