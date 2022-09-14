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






