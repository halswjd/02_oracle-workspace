-- 저장
SELECT* FROM EMPLOYEE
WHERE EMP_NAME = '선동일';
--SELECT * FROM DEPARTMENT
--WHERE DEPT_ID = 'D9';
--SELECT * FROM LOCATION
--WHERE LOCAL_CODE_'L1';
--SELECT * FROM NATIONAL
--WHERE NATIONAL_CODE = 'KO';

/*
    < JOIN >
    두 개 이상의 테이블에서 데이터를 조회하고자 할 대 사용되는 구문
    조회결과는 하나의 결과물(RESULT SET)로 나옴
    
    관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 데이터를 담고 있음 (중복을 최소화하기 위해 최대한 쪼개서 관리함!)
    
    -- 어떤 사원이 어떤 부서에 속해있는지 궁금함! 코드말고.. 이름으로..
    
    --> 관계형 데이터베이스에서 SQL문을 이용한 테이블간에 "관계"를 맺는 방법
        ( 무작정 다 조회를 해오는게 아니라 각 테이블간 연결고리로써의 데이터를 매칭해서 조회 시켜야함!! )
        
        JOIN 크게 "오라클 전용구문"과 "ANSI 구문" (ANSI == 미국국립표준협회, 아스키코드표 만드는 단체)
        
                                                [ JOIN 용어 정리 ]
                오라클 전용 구문                                                      ANSI 구문
-----------------------------------------------------------------------------------------------------------------------------
                    등가조인                                                내부 조인 ([INER] JOIN ) => JOIN USING / ON
                ( EQUAL JOIN )                                             자연 조인 ( NATURAL JOIN ) => JOIN USING
-----------------------------------------------------------------------------------------------------------------------------
                    포괄조인                                                왼쪽 내부 조인 ( LEFT OUTER JOIN )     
                ( LEFT OUTER )                                            오른쪽 내부 조인 ( RIGHT OUTER JOIN )
                ( RIGHT OUTER )                                             전체 외부 조인 ( FULL OUTER JOIN )
------------------------------------------------------------------------------------------------------------------------------
                자체조인 ( SELFT JOIN )                                          JOIN ON
            비등가 조인 ( NON EQUAL JOIN )
-------------------------------------------------------------------------------------------------------------------------------    

*/

-- 전체 사원들의 사번, 사원명, 부서코드 , 부서명 조회하고자 할 때
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 전체 사원들의 사번, 사원명, 직급코드, 직급을 조회하고자 할 때
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT *
FROM JOB;

/*
    1. 등가조인 (EQUAL JOIN) / 내부조인 (INNER JOIN)
    연결하고자 하는 컬럼의 값이 일치하는 행들만 조회돼서 조회 => 일치하는 값이 없는 행은 조회에서 제외!

*/

-- >> 오라클 전용구문
-- FROM절에 조회하고자 하는 테이블들을 ','를 구분자로나열
-- WHERE절에 매칭시킬 컬럼(연결고리)에 대한 조건을 제시함

-- 1) 연결 할 두 컬럼명이 다른 경우 (EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
-- 사번, 사원명, 부서코드, 부서명을 같이 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> 일치하는 값이 없는 행은 조회에서 제외된거 확인 가능
--> DEPT_CODE 가 NULL인 사원 조회X, DEPT_ID가 D3, D4, D7 조회X

-- 2) 연결한 두 컬럼명이 같은 경우 (EMPLOYEE : JOB_CODE, JOB : JOB_CODE)
-- 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE;
-- column ambiguously defined 오류 발생
-- ambiguously : 애매하다, 모호하다

-- 해결방법1) 테이블명을 이용해 명시하는 방법
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 해결방법2) 테이블에 별칭을 부여해서 이용하는 방법 ***
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


SELECT *
FROM JOB;

-- >> ANSI 구문
-- FROM절에 기준이 되는 테이블을 하나 기술 한 후
-- JOIN절에 같이 조회하고자 하는 테이블 기술 + 매칭시킬 컬럼에 대한 조건 기술
-- JOING USING, JOIN ON

-- 1) 연결할 두 컬럼명이 다른 경우 (EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
-- 오로지 JOIN ON 구문으로만 사용 가능!!!
-- 사번, 사원명, 부서코드, 부서명
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) 연결한 두 컬럼명이 같은 경우 (EMPLOYEE : JOB_CODE, JOB : JOB_CODE)
-- JOIN ON, JOIN USING 구문 사용 가능!
-- 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON (JOB_CODE = JOB_CODE);
-- column ambiguously defined

-- 해결방법1) 테이블명 또는 별칭을 이용해서 명시하는 방법
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- 해결방법2) JOIN USING 구문 사용하는 방법 (두 컬럼명이 일치할때만 사용 가능) ***
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

-- [참고사항]----------
-- 자연조인(NATURAL JOIN) : 각 테이블마다 동일한 컬럼이 한 개만 존재할 경우
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- 추가적인 조건도 당근 제시 가능
-- 직급이 대리인 사원의 이름, 직급명, 급여 조회
-- >> 오라클 전용 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '대리';
--                            AND E.JOB_CODE = 'J6';

-- >> ANSI 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE --1
JOIN JOB USING (JOB_CODE) -- 2
WHERE JOB_NAME = '대리'; -- 3

----------------------------------------------- 실습문제 -----------------------------------------------------
-- 1. 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회
-- >> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '인사관리부';
-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';


-- 2. DEPARTMENT과 LOCATION을 참고해서 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
-- >> 오라클 전용구문
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
-- >> ANSI 구문
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);


-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-- >> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;
-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. 부서가 총무부가 아닌 사원들의 사원명, 급여, 부서명 조회
-- >> 오라클 전용구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_CODE AND DEPT_TITLE != '총무부';
-- DEPT_ID, DEPT_TITLE
-- >> ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE DEPT_TITLE != '총무부';
-- 지금 현재 DEPT_CODE가 NULL 인건 나오고 있지 않음! -> 등가조인이라서

-----------------------------------------------------------------------------------------------------------

/*
    2, 포괄 조인 / 외부 조인 (OUTER JOIN)
    두 테이블간의 JOIN시 일치하지않는 행도 포함시켜서 조회 가능
    단, 반드시 LEFT / RIGHT 지정해야됨!! 즉 기준이 되는 테이블은 지정해야됨
*/

-- 사원명, 부서명, 급여, 연봉
SELECT EMP_NAME, DEPT_TITLE, SALARY,SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 아직 부서배치가 안된 사원 2명에 대한 정보가 조회X
-- 부서에 배정된 사원이 없는 부서 같은 경우도 조회X

-- 1) LEFT [OUTER] JOIN : 두 테이블 중 왼편에 기술된 테이블 기준으로 JOIN
-->> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE -- EMPLOYEE에 있는건 무조건 다 나오는거임! 
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 부서배치를 받지 않았던 2명의 사원 정보도 조회됨!

-->> 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- 기준으로 삼고자하는 테이블의 반대편 컬럼뒤에 (+) 붙이기 

-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른편에 기술된 테이블을 기준으로 JOIN
-->> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- 속해있던 사원이 없는 부서도 다 조회됨

-->> 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;


-- 3) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있음 (단, 오라클전용구문으로는 안됨)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- LEFT, RIGHT JOIN 다 합친 개념


/*
    3. 비등가 조인 (NON EQUAL JOIN) => 얘는 그냥 참고용
    매칭시킬 컬럼에 대한 조건 작성시 '=(등호)'를 사용하지 않는 조인문
    ANSI 구문으로는 JOIN ON 만 사용 가능
    
*/

SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE;

SELECT * FROM SAL_GRADE;

-- 사원명, 급여, 최대 월급 한도
-- >> 오라클 전용 구문
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- >> ANSI 구문
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

----------------------------------------------------------------------------------------------------------------------

/*
    4. 자체조인 (SELF JOIN)
    같은 테이블을 다시 한번 조인하는 경우
*/

SELECT * FROM EMPLOYEE;
-- MANAGER_ID = EMP_ID

-- 전체사원의 사번, 사원명, 사원부서코드,    => EMPLOYEE E
-- 사수의 사번, 사수명, 사수부서코드         => EMPLOYEE M
-- >> 오라클 전용 구문
SELECT E.EMP_ID AS "사원사번" , E.EMP_NAME AS "사원명", E.DEPT_CODE AS "사원부서코드", 
       M.EMP_ID AS "사수사번", M.EMP_NAME AS "사수명", M.DEPT_CODE AS "사수부서코드"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

SELECT EMP_ID AS "사원사번", EMP_NAME AS "사원명", DEPT_CODE AS "사원부서코드",
       EMP_ID AS "사수사번

-- >> ANSI 구문
SELECT E.EMP_ID AS "사원사번" , E.EMP_NAME AS "사원명", E.DEPT_CODE AS "사원부서코드", 
       M.EMP_ID AS "사수사번", M.EMP_NAME AS "사수명", M.DEPT_CODE AS "사수부서코드"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;
-----------------------------------------------------------------------------------------------

/*
    < 다중 JOIN >
    2개 이상의 테이블을 가지고 JOIN 할 때
*/

-- 사번, 사원명, 부서명, 직급명 조회
SELECT * FROM EMPLOYEE;   -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;        --            JOB_CODE

-- >> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);

-- 사번, 사원명, 부서명, 지역명
SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE

-- >> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;

-- > ANSI 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 이렇게는 안됨! 처음 EMPLOYEE랑 LOCATION이 조인이 안됨(연결고리 순서 지키기!!)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

---------------------------------- 실습문제 ---------------------------------------

-- 1. 사번, 사원명, 부서명, 지역명, 국가명 조회 (EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL)
-- >> 오라클 전용 구문
SELECT * FROM EMPLOYEE; -- DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ ID, LOCATION_ID
SELECT * FROM NATIONAL; -- NATIONAL_CODE
SELECT * FROM LOCATION; --      ''        LOCAL_CODE

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME ,NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, NATIONAL N, LOCATION L
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE AND N.NATIONAL_CODE = L.NATIONAL_CODE;

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME ,NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);

-- 2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 해당 급여등급에서 받을 수 있는 최대금액 조회
-- >> 오라클
SELECT * FROM EMPLOYEE; -- DEPT_CODE    JOB_CODE    SAL_LEVEL
SELECT * FROM DEPARTMENT;-- DEPT_ID                             LOCATION_ID
SELECT * FROM JOB;
SELECT * FROM LOCATION; --                                         LOCAL_CODE   NATIONAL_CODE
SELECT * FROM NATIONAL; --                                                      NATIONAL_CODE            
SELECT * FROM SAL_GRADE; --                        SAL_LEVEL

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME ,NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E, DEPARTMENT, NATIONAL N, LOCATION L, SAL_GRADE S, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE AND LOCATION_ID = LOCAL_CODE AND N.NATIONAL_CODE = L.NATIONAL_CODE
AND E.SAL_LEVEL = S.SAL_LEVEL;

-- >> ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME ,NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
JOIN SAL_GRADE USING (SAL_LEVEL);

