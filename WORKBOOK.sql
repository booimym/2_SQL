SELECT *
FROM TB_DEPARTMENT 

--1번
SELECT STUDENT_NAME 이름 , STUDENT_ADDRESS 주소지
FROM TB_STUDENT 
ORDER BY STUDENT_NAME;

--2번
SELECT STUDENT_NAME ,STUDENT_SSN 
FROM TB_STUDENT 
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;


--3번
SELECT STUDENT_NAME , STUDENT_NO ,STUDENT_ADDRESS 
FROM TB_STUDENT
WHERE  SUBSTR(STUDENT_NO,1,1) = '9' 
AND (SUBSTR(STUDENT_ADDRESS,1,3) = '경기도' OR SUBSTR(STUDENT_ADDRESS,1,3) = '강원도')
ORDER BY STUDENT_NAME;

--4번
SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME ='법학과'
ORDER BY PROFESSOR_SSN;

--5번
SELECT STUDENT_NO,TO_CHAR(POINT,9999.99)
FROM TB_GRADE 
WHERE TERM_NO = 200402 AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC ,STUDENT_NO;
 
--6번(O)
--학생번호,학생이름,학과이름
SELECT STUDENT_NO, STUDENT_NAME,DEPARTMENT_NAME 
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

--7번(O)
SELECT CLASS_NAME, DEPARTMENT_NAME 
FROM TB_CLASS 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

--8번 ?
SELECT C.CLASS_NAME, P.PROFESSOR_NAME 
FROM TB_CLASS C
JOIN TB_PROFESSOR P ON (C.DEPARTMENT_NO = P.DEPARTMENT_NO);

--8번 이렇게 하면 됨.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR  
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);

--9번?

SELECT CLASS_NAME, PROFESSOR_NAME,CATEGORY
FROM TB_CLASS_PROFESSOR  
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_PROFESSOR  USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE CATEGORY = '인문사회'


--10번?
--음악학과학생들의 전체평점
SELECT S.STUDENT_NO 학번 , S.STUDENT_NAME 학생이름, G.POINT 전체평점
FROM TB_STUDENT S
JOIN TB_GRADE G ON (G.STUDENT_NO = S.STUDENT_NO)
JOIN TB_DEPARTMENT D ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME ='음악학과';


--11번(O)
--학번 A313047,학과이름,학생이름,지도교수이름


SELECT DEPARTMENT_NAME 학과이름,STUDENT_NAME 학생이름 , PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

--12번(O) 


SELECT STUDENT_NAME,TERM_NO
FROM TB_GRADE
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_STUDENT USING (STUDENT_NO)
WHERE CLASS_NAME = '인간관계론' 
AND SUBSTR(TERM_NO,1,4)='2007';

--13번(o) 
--(담당과목교슈 배정 안받은 게 뭐임?)
--예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아
--그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
--(기존 워크북 PDF에 나타난 조회 결과는 DB 버전이 낮아 현재와 조회 방식이 다름.
--결과 행의 수만 동일하게 조회하자)
--SELECT CATEGORY,DEPARTMENT_NAME,CLASS_NAME
--FROM TB_DEPARTMENT 
--JOIN TB_CLASS USING (DEPARTMENT_NO)
--WHERE DEPARTMENT_NO NOT IN (SELECT DEPARTMENT_NO 
--							FROM TB_PROFESSOR);
					
SELECT DEPARTMENT_NAME,CLASS_NAME
FROM TB_DEPARTMENT
JOIN TB_CLASS USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO NOT IN (SELECT DISTINCT DEPARTMENT_NO 
							FROM TB_PROFESSOR WHERE DEPARTMENT_NO IS NOT NULL)
AND CATEGORY = '예체능';

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
WHERE PROFESSOR_NO IS NULL AND CATEGORY = '예체능';
						
--14번
--학과: 서반아이어/지도교수

--1. 왜 널값없어
--2. 왜 JOIN을 반대로 하면 안되는뎅 왜!!!

SELECT STUDENT_NAME, COACH_PROFESSOR_NO , PROFESSOR_NAME 
FROM TB_STUDENT S
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT D USING (S.DEPARTMENT_NO)


SELECT DEPARTMENT_NAME,STUDENT_NAME,PROFESSOR_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE DEPARTMENT_NAME  = '서반아어학과'





--15번(o)
--휴학생이 아닌 학생 & 평점 4.0
--학번,이름,학과이름,평점

SELECT STUDENT_NAME,ABSENCE_YN ,AVG(POINT)
FROM TB_STUDENT 
JOIN TB_GRADE USING(STUDENT_NO)
GROUP BY STUDENT_NO,STUDENT_NAME
HAVING AVG(POINT)>= 4.0;


SELECT STUDENT_NAME,DEPARTMENT_NAME,STUDENT_NO,AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME,DEPARTMENT_NAME
HAVING AVG(POINT)>=4.0;






