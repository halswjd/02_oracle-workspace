
/*
    DQL ( QUERY ������ ���� ��� ) : SELECT
    ***
    DML ( MANIPULATION ������ ���� ��� ) : [SELECT], INSERT, UPDATE, DELETE
    DDL ( DEFINITION ������ ���� ��� ) : CREATE, ALTER, DROP
    DCL ( CONTROL ������ ���� ��� ) : GRANT, REVOKE, [COMMIT, ROLLBACK]
    ***
    TCL ( TRANSACTION Ʈ������ ���� ��� ) : COMMIT, ROLLBACK
    
    < DML : DATE MANIPULATION LANGAUGE >
    ������ ���� ���
    
    ���̺� ���� ����(INSERT)�ϰų�, ����(UPDATE)�ϰų�, ����(DELETE)�ϴ� ����
*/

/*
    1. INSERT
       ���̺� ���ο� ���� �߰��ϴ� ����
       
       [ǥ����]
       1) INSERT INTO ���̺�� VALUES(��1, ��2, ��3,...);
          ���̺� ��� �÷��� ���� ���� ���� �����ؼ� �� �� INSERT �ϰ��� �� �� ���
          �÷� ������ ���Ѽ� VALUES�� ���� �����ؾߵ�!
          
          �����ϰ� ���� �������� ��� => not enough values ���� �߻�!
          ���� �� ���� �������� ��� => too many values ���� �߻�!
          
        �߰� �߰��� ������!!! (������ ��)

*/

INSERT INTO EMPLOYEE 
VALUES(900, '������', '900101-1234567', 'cha_00@kh.or.kr', '01011112222', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '������';

/*
    2) INSERT INTO ���̺�� (�÷���, �÷���, �÷���) VALUES (��1, ��2, ��3)
       ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���
       �׷��� �� �� ������ �߰��Ǳ� ������
       ������ �ȵ� �÷��� �⺻�����δ� NULL�� ��!
       => NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� �� �����ؾߵ�!
       ��, DEFAULT ���� ���� ���� NULL�� �ƴ� DEFAULT ���� ����.
*/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE) 
VALUES(901, '������', '880101-1111111', 'J1', 'S2', SYSDATE);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '������';
-- ENT_YN �� ����Ʈ������ ������!

-- ������ȸ�翡�� ���� INSERT����
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
      , '������'
      , '880101-1111111'
      , 'J1'
      , 'S2'
      , SYSDATE
      );
      
----------------------------------------------------------------------------------------------------

/*
    3) INSERT INTO ���̺�� (��������); -- ���󵵴� ����
       VALUES�� �� ���� ����ϴ°� ��ſ�
       �������� ��ȸ�� ������� ��°�� INSERT ����! (�������� INSERT ����!)
*/

-- ���ο� ���̺� ����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

-- EMPLOYEE���̺� ��ü ������� ���, �̸�, �μ��� ��ȸ
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

-- �켱 �׽�Ʈ�� ���̺� �����
-- ������ �賢��
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
     FROM EMPLOYEE
    WHERE 1 = 0;
    
SELECT * FROM EMP_DEPT;


CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_MANAGER;

-- �μ��ڵ尡 D1�� ������� ���, �̸�, �μ��ڵ�, �Ի���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    [ǥ����]
    INSERT ALL
    INTO ���̺��1 VALUES(�÷���, �÷���, ...)
    INTO ���̺��2 VALUES(�÷���, �÷���, ...)
    ��������;
*/

INSERT ALL
INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

-- * ������ ����ؼ� �� ���̺� INSERT ����?

-- 2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�
-- ���̺� ������ �貸�� �����
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;
    
-- 2000 �⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    [ǥ����]
    INSERT ALL
    WHEN ����1 THEN 
        INTO ���̺��1 VALUES(�÷���, �÷���)
    WHEN ����2 THEN
        INTO ���̺��2 VALUES(�÷���, �÷���)
    ��������;
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
    ���̺� ��ϵǾ��ִ� ������ �����͸� �����ϴ� ����
    
    [ǥ����]
    UPDATE ���̺��
    SET �÷��� = �ٲܰ�,
        �÷��� = �ٲܰ�,
        ...             --> �������� �÷��� ���ú��� ����, (,�� �����ؾߵ�! AND �ƴ�!)
    [WHERE ����];        --> �����ϸ� ��ü ���� ��� ���� �����Ͱ� ����ȴ�...! �׷��� �� ���� ����
*/

-- ���纻 ���̺� ���� �� �۾�
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- D9 �μ��� �μ����� '������ȹ��'���� ����
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'; -- �ѹ���
--> ���ǽ� ������ ��� DEPT_TITLE�� �ٲ�

ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��' -- �ѹ���
WHERE DEPT_ID = 'D9'; 

SELECT * FROM DEPT_COPY;


-- �켱 ���纻 ���� ����
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;

-- ���ö ����� �޿��� 100�������� ����! ������ ���
UPDATE EMP_SALARY
SET SALARY = 1000000 -- 3700000
WHERE EMP_NAME = '���ö';

-- ������ ��� �޿��� 700�������� ����!, ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = 0.2 -- 8000000 0.3
WHERE EMP_NAME = '������';

-- ��ü����� �޿��� ������ �޿��� 10% �λ��� �ݾ� (�����޿� * 1.1)
SELECT * FROM EMP_SALARY;

UPDATE EMP_SALARY
SET SALARY = SALARY*1.1;


-- * UPDATE �� �������� ��� ����
/*
    UPDATE ���̺��
    SET �÷��� = ��������
    WHERE ����;
*/

-- ���� ����� �޿��� ���ʽ����� ����Ļ���� �޿��� ���ʽ� ������ ����
SELECT EMP_NAME, SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '����'; -- 1518000, NULL

SELECT EMP_NAME, SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '�����'; -- 3740000, 0.2

-- ������ ��������
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '�����'), -- ������ �������� => '='���� ����, 
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

-- ���߿� ��������
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����') -- ���߿� ��������
WHERE EMP_NAME = '����';

-- ASIA �������� �ٹ��ϴ� ������� ���ʽ� ���� 0.3���� ����
-- ASIA �������� �ٹ��ϴ� ����� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT; -- LOCATION_ID
SELECT * FROM LOCATION; -- LOCAL_CODE

SELECT /*EMP_NAME, LOCAL_NAME*/ EMP_ID -- ���������� ���� �� �ֱ⶧���� �ĺ��� �� �ִ� �ĺ��ڷ� ���°� ����!
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
WHERE EMP_NAME = '������';

-----------------------------------------------------------------------------------------------------------------
-- UPDATE �� ������ �ش� �÷��� ���� �������� ����Ǹ� �ȵ�!
-- ����� 200���� ����� �̸��� NULL�� ����

UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID = 200;
-- ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
-- NOT NULL �������� ����

-- ���ö ����� �����ڵ� J9�� ����
UPDATE EMPLOYEE
SET JOB_CODE = 'J9'
WHERE EMP_NAME = '���ö';
-- ORA-02291: integrity constraint (KH.SYS_C007125) violated - parent key not found
-- FOREIGN KEY �������� ����!
-- JOB_CODE�� �����ִ� ������ �ٲٴ��� JOB_CODE�� J9�� �߰��ϴ���

-------------------------------------------------------------------------------------------------------------------
COMMIT;

/*
     4. DELETE
     ���̺� ��ϵ� �����͸� �����ϴ� ���� (�� �� ������ ������)
     
     [ǥ����]
     DELETE FROM ���̺��
     [WHERE ����]; --> WHERE ���� ���� ���ϸ� ��ü �� �� ������
*/

-- ������ ����� ������ �����
DELETE FROM EMPLOYEE; -- WHERE ���� ���� ���ؼ� ��ü �� �� ������

SELECT * FROM EMPLOYEE;

ROLLBACK; -- ������ Ŀ�� �������� ���ư�

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '������';

COMMIT;

ROLLBACK; -- '������', '������' ���� �� Ŀ���� �߱� ������ �ѹ��ص� ���� �ȵ�
          --> Ŀ���Ҷ����� �����ϰ�!!
          
-- DEPT_ID �� D1�� �μ��� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- ORA-02292: integrity constraint (KH.SYS_C007124) violated - child record found
-- �ܷ�Ű �������� ����!
-- D1�� �����پ��� �ڽĵ����Ͱ� �ֱ� ������ ������ �ȵ�!!

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- DEPT_ID�� D3�� �μ��� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';

SELECT * FROM DEPARTMENT;

ROLLBACK;

-- * TRUNCATE : ���̺��� ��ü ���� ������ �� ���Ǵ� ����
--              DELETE���� ���� �ӵ��� ����
--              ������ ���� ���� �Ұ�, ROLLBACK �Ұ�!!
-- [ǥ����] TRUNCATE TABLE ���̺��

SELECT * FROM EMP_SALARY;
COMMIT;

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;










