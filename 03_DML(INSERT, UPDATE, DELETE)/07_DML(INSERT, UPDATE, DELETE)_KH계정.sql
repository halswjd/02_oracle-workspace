
/*
    DQL ( QUERY 데이터 질의 언어 ) : SELECT
    ***
    DML ( MANIPULATION 데이터 조작 언어 ) : [SELECT], INSERT, UPDATE, DELETE
    DDL ( DEFINITION 데이터 정의 언어 ) : CREATE, ALTER, DROP
    DCL ( CONTROL 데이터 제어 언어 ) : GRANT, REVOKE, [COMMIT, ROLLBACK]
    ***
    TCL ( TRANSACTION 트랜젝션 제어 언어 ) : COMMIT, ROLLBACK
    
    < DML : DATE MANIPULATION LANGAUGE >
    데이터 조작 언어
    
    테이블에 값을 삽입(INSERT)하거나, 수정(UPDATE)하거나, 삭제(DELETE)하는 구문
*/

/*
    1. INSERT
       테이블에 새로운 행을 추가하는 구문
       
       [표현법]
       1) INSERT INTO 테이블명 VALUES(값1, 값2, 값3,...);
          테이블에 모든 컬럼에 대한 값을 직적 제시해서 한 행 INSERT 하고자 할 때 사용
          컬럼 순번을 지켜서 VALUES에 값을 나열해야됨!
          
          부족하게 값을 제시했을 경우 => not enough values 오류 발생!
          값을 더 많이 제시했을 경우 => too many values 오류 발생!
          
        중간 중간에 저장해!!! (윤지영 曰)

*/

INSERT INTO EMPLOYEE 
VALUES(900, '차은우', '900101-1234567', 'cha_00@kh.or.kr', '01011112222', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '차은우';

/*
    2) INSERT INTO 테이블명 (컬럼명, 컬럼명, 컬럼명) VALUES (값1, 값2, 값3)
       테이블에 내가 선택한 컬럼에 대한 값만 INSERT할 때 사용
       그래도 한 행 단위로 추가되기 때문에
       선택이 안된 컬럼은 기본적으로는 NULL이 들어감!
       => NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값 제시해야됨!
       단, DEFAULT 값이 없는 경우는 NULL이 아닌 DEFAULT 값이 들어간다.
*/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE) 
VALUES(901, '주지훈', '880101-1111111', 'J1', 'S2', SYSDATE);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '주지훈';
-- ENT_YN 은 디폴트값으로 들어가있음!

-- 개발자회사에서 쓰는 INSERT구문
INSERT 
  INTO EMPLOYEE
       (
         EMP_ID
       , EMP_NAME
       , EMP_NO
       , JOB_CODE
       , SAL_LEVEL
       , HIRE_DATE
       )
VALUES
      (
        901
      , '주지훈'
      , '880101-1111111'
      , 'J1'
      , 'S2'
      , SYSDATE
      );
      
----------------------------------------------------------------------------------------------------

/*
    3) INSERT INTO 테이블명 (서브쿼리); -- 사용빈도는 적음
       VALUES로 값 직접 명시하는거 대신에
       서브쿼리 조회된 결과값을 통째로 INSERT 가능! (여러행을 INSERT 가능!)
*/

-- 새로운 테이블 셋팅
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

-- EMPLOYEE테이블에 전체 사원들의 사번, 이름, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE);

INSERT INTO EMP_01 (
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
);

SELECT * FROM EMP_01;


------------------------------------------------------------------------------------------------------------------

/*
    2. INSERT ALL
*/

-- 우선 테스트할 테이블 만들기
-- 구조만 배끼기
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
     FROM EMPLOYEE
    WHERE 1 = 0; -- FALSE 조건 -> 구조만배끼기
    
SELECT * FROM EMP_DEPT;


CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_MANAGER;

-- 부서코드가 D1인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    [표현식]
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
    INTO 테이블명2 VALUES(컬럼명, 컬럼명, ...)
    서브쿼리;
*/

INSERT ALL
INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

-- * 조건을 사용해서 각 테이블에 INSERT 가능?

-- 2000년도 이전 입사한 입사자들에 대한 정보 담을 테이블
-- 테이블 구조만 배껴서 만들기
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;
    
-- 2000 년도 이후 입사한 입사자들에 대한 정보 담을 테이블
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    [표현식]
    INSERT ALL
    WHEN 조건1 THEN 
        INTO 테이블명1 VALUES(컬럼명, 컬럼명)
    WHEN 조건2 THEN
        INTO 테이블명2 VALUES(컬럼명, 컬럼명)
    서브쿼리;
*/

INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD; -- 8
SELECT * FROM EMP_NEW; -- 17

------------------------------------------------------------------------------------------------------

/*
    3. UPDATE
    테이블에 기록되어있는 기존의 데이터를 수정하는 구문
    
    [표현식]
    UPDATE 테이블명
    SET 컬럼명 = 바꿀값,
        컬럼명 = 바꿀값,
        ...             --> 여러개의 컬럼값 동시변경 가능, (,로 나열해야됨! AND 아님!)
    [WHERE 조건];        --> 생략하면 전체 행의 모든 행의 데이터가 변경된다...! 그래서 꼭 조건 쓰자
*/

-- 복사본 테이블 생성 후 작업
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- D9 부서의 부서명을 '전략기획팀'으로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'; -- 총무부
--> 조건식 생략시 모든 DEPT_TITLE행 바뀜

ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀' -- 총무부
WHERE DEPT_ID = 'D9'; 

SELECT * FROM DEPT_COPY;


-- 우선 복사본 떠서 진행
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;

-- 노옹철 사원의 급여를 100만원으로 변경! 데이터 백업
UPDATE EMP_SALARY
SET SALARY = 1000000 -- 3700000
WHERE EMP_NAME = '노옹철';

-- 선동일 사원 급여를 700만원으로 변경!, 보너스도 0.2로 변경
UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = 0.2 -- 8000000 0.3
WHERE EMP_NAME = '선동일';

-- 전체사원의 급여를 기존의 급여를 10% 인상한 금액 (기존급여 * 1.1)
SELECT * FROM EMP_SALARY;

UPDATE EMP_SALARY
SET SALARY = SALARY*1.1;


-- * UPDATE 시 서브쿼리 사용 가능
/*
    UPDATE 테이블명
    SET 컬럼명 = 서브쿼리
    WHERE 조건;
*/

-- 방명수 사원의 급여와 보너스값을 유재식사원의 급여와 보너스 값으로 변경
SELECT EMP_NAME, SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '방명수'; -- 1518000, NULL

SELECT EMP_NAME, SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '유재식'; -- 3740000, 0.2

-- 단일행 서브쿼리
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '유재식'), -- 단일행 서브쿼리 => '='연산 가능, 
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

-- 다중열 서브쿼리
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식') -- 다중열 서브쿼리
WHERE EMP_NAME = '방명수';

-- ASIA 지역에서 근무하는 사원들의 보너스 값을 0.3으로 변경
-- ASIA 지역에서 근무하는 사원들 조회
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT; -- LOCATION_ID
SELECT * FROM LOCATION; -- LOCAL_CODE

SELECT /*EMP_NAME, LOCAL_NAME*/ EMP_ID -- 동명이인이 있을 수 있기때문에 식별할 수 있는 식별자로 쓰는게 좋다!
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
--WHERE SUBSTR(LOCAL_NAME, 1, 4) = 'ASIA';
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_NAME IN (SELECT EMP_ID
                    FROM EMP_SALARY
                    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                    WHERE LOCAL_NAME LIKE 'ASIA%');

SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '차은우';

-----------------------------------------------------------------------------------------------------------------
-- UPDATE 할 때에도 해당 컬럼에 대한 제약조건 위배되면 안됨!
-- 사원이 200번인 사원의 이름을 NULL로 변경

UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID = 200;
-- ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
-- NOT NULL 제약조건 위배

-- 노옹철 사원의 직급코드 J9로 변경
UPDATE EMPLOYEE
SET JOB_CODE = 'J9'
WHERE EMP_NAME = '노옹철';
-- ORA-02291: integrity constraint (KH.SYS_C007125) violated - parent key not found
-- FOREIGN KEY 제약조건 위배!
-- JOB_CODE에 속해있는 값으로 바꾸던가 JOB_CODE에 J9를 추가하던가

-------------------------------------------------------------------------------------------------------------------
COMMIT;

/*
     4. DELETE
     테이블에 기록된 데이터를 삭제하는 구문 (한 행 단위로 삭제됨)
     
     [표현식]
     DELETE FROM 테이블명
     [WHERE 조건]; --> WHERE 조건 제시 안하면 전체 행 다 삭제됨
*/

-- 차은우 사원의 데이터 지우기
DELETE FROM EMPLOYEE; -- WHERE 조건 제시 안해서 전체 행 다 삭제됨

SELECT * FROM EMPLOYEE;

ROLLBACK; -- 마지막 커밋 시점으로 돌아감

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '차은우';

SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '주지훈';

COMMIT;

ROLLBACK; -- '차은우', '주지훈' 삭제 후 커밋을 했기 때문에 롤백해도 복구 안됨
          --> 커밋할때에는 신중하게!!
          
-- DEPT_ID 가 D1인 부서를 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- ORA-02292: integrity constraint (KH.SYS_C007124) violated - child record found
-- 외래키 제약조건 위반!
-- D1을 가져다쓰는 자식데이터가 있기 때문에 삭제가 안됨!!

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- DEPT_ID가 D3인 부서를 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';

SELECT * FROM DEPARTMENT;

ROLLBACK;

-- * TRUNCATE : 테이블의 전체 행을 삭제할 때 사용되는 구문
--              DELETE보다 수행 속도가 빠름
--              별도의 조건 제시 불가, ROLLBACK 불가!!
-- [표현식] TRUNCATE TABLE 테이블명

SELECT * FROM EMP_SALARY;
COMMIT;

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;










