
/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    트랜잭션 제어 언어
    
    * 트랜젝션(TRANSACTION) 
    - 데이터베이스의 논리적 연산단위
    - 데이터의 변경사항(DML 추가, 수정, 삭제)들을 하나의 트랜잭션에 묶어서 처리
      DML문 한 개를 수행할 때 트랜젝션이 존재하면 해당 트랜젝션에 같이 묶어서 처리
                            트랜젝션이 존재하지 않으면 트랜젝션 만들어서 묶음
      COMMIT 하기 전까지 변경사항들을 하나의 트랜젝션에 담게됨
      커밋을 해야만이 실제 DB에 반영이 된다고 생각하면 됨!
      - 트랜젝션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML)
      
      COMMIT(트랜젝션 종료 처리 후 확정)
      ROLLBACK(트랜젝션 취소)
      SAVAPOINT(임시저장)
      
      - COMMIT; 진행 : 한 트랜젝션에 담겨있는 변경사항들을 실제 DB에 변겨시키겠다는 의미 (후에 트랜젝션 사라짐)
      - ROLLBACK; 진행 : 한 트랜젝션에 담겨있는 변경사항들을 삭제(취소) 한 후 마지막 커밋 시점으로 돌아감.
      - SAVEPOINT 포인트명; 진행 : 현재 이 시점에서 해당 포인트명으로 임시저장 지점을 정의해두는 것
                                 ROLLBACK 진행시 전체 변경사항들을 다 삭제하는게 아니라 일부만 롤백가능
*/

SELECT * FROM EMP_01;

-- 사번이 900번인 사번 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 900;
-- 뭔가 진짜 삭제된것처럼 보임!
-- DML 작성 > 트랜젝션 생김 > DML구문 들어감 => DML구문 실행된것처럼 보이지만 실제DB에 반영은 안됨

DELETE FROM EMP_01
WHERE EMP_ID = 901;
-- 앞전에 생긴 트랜젝션이 구문 담김

ROLLBACK;
--> 트랜젝션에 있던 모든 구문을 취소하고 마지막 커밋시점으로 돌아감
--> 변경사항이 취소되고 트랜젝션도 없어짐. 데이터 다시 되살아난다.

DELETE FROM EMP_01
WHERE EMP_ID = 200;
-- DML 구문 > 트랜젝션이 없네? > 트랜젝션 생성 후 구문 담김

SELECT * FROM EMP_01;

-- 800번, 황민현, 총무부 사원 추가
INSERT INTO EMP_01 
VALUES (800, '황민현', '총무부'); 
-- 앞전에 생긴 트랜젝션에 구문 담김

COMMIT;
-- 트랜젝션에 담겨있던 DML구문 실제DB에 반영됨!

-- 200번 사원 다시 되돌리고싶은데..
ROLLBACK; -- 200번 사원 되돌릴수없음... 이미 커밋해서!

-----------------------------------------------------------------------------------------------------------------------------

-- 217, 216, 214 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

-- 임시저장점 잡기 --> 트랜젝션에 추가 --> 실제 DB 반영X
SAVEPOINT SP;

-- 801, 안효섭, 인사관리부 사원 추가
INSERT INTO EMP_01
VALUES (801, '안효섭', '인사관리부');

-- 218 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT * FROM EMP_01;

-- 801 추가랑 218 삭제만 취소하고싶다!
ROLLBACK TO SP; --> SP지점 이후의 DML구문 취소(삭제)

COMMIT; --> SP지점 이전의 DML구문 실제 DB에 반영

------------------------------------------------------------------------------------------------

-- 900, 901 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID IN (901,900);

-- 218 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT * FROM EMP_01;

-- DDL문
CREATE TABLE TEST(
    TID NUMBER
);

-- 900,901,218 사원 지운거 다시 되돌리자!
ROLLBACK; -- 롤백 안됨
-- DDL문 (CREATE, ALTER, DROP)을 수행하는 순간 기존에 트랜젝션에 있던 변경사항들을 무조건 COMMIT (실제 DB에 반영)!!
-- 즉, DDL문 수행 전 변경사항이 있었다면 정확히 픽스(COMMIT 또는 ROLLBACK)하고 하자!





















