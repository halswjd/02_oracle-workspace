-- ����
SELECT* FROM EMPLOYEE
WHERE EMP_NAME = '������';
--SELECT * FROM DEPARTMENT
--WHERE DEPT_ID = 'D9';
--SELECT * FROM LOCATION
--WHERE LOCAL_CODE_'L1';
--SELECT * FROM NATIONAL
--WHERE NATIONAL_CODE = 'KO';

/*
    < JOIN >
    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� �����͸� ��� ���� (�ߺ��� �ּ�ȭ�ϱ� ���� �ִ��� �ɰ��� ������!)
    
    -- � ����� � �μ��� �����ִ��� �ñ���! �ڵ帻��.. �̸�����..
    
    --> ������ �����ͺ��̽����� SQL���� �̿��� ���̺��� "����"�� �δ� ���
        ( ������ �� ��ȸ�� �ؿ��°� �ƴ϶� �� ���̺� ������ν��� �����͸� ��Ī�ؼ� ��ȸ ���Ѿ���!! )
        
        JOIN ũ�� "����Ŭ ���뱸��"�� "ANSI ����" (ANSI == �̱�����ǥ����ȸ, �ƽ�Ű�ڵ�ǥ ����� ��ü)
        
                                                [ JOIN ��� ���� ]
                ����Ŭ ���� ����                                                      ANSI ����
-----------------------------------------------------------------------------------------------------------------------------
                    �����                                                ���� ���� ([INER] JOIN ) => JOIN USING / ON
                ( EQUAL JOIN )                                             �ڿ� ���� ( NATURAL JOIN ) => JOIN USING
-----------------------------------------------------------------------------------------------------------------------------
                    ��������                                                ���� ���� ���� ( LEFT OUTER JOIN )     
                ( LEFT OUTER )                                            ������ ���� ���� ( RIGHT OUTER JOIN )
                ( RIGHT OUTER )                                             ��ü �ܺ� ���� ( FULL OUTER JOIN )
------------------------------------------------------------------------------------------------------------------------------
                ��ü���� ( SELFT JOIN )                                          JOIN ON
            �� ���� ( NON EQUAL JOIN )
-------------------------------------------------------------------------------------------------------------------------------    

*/

-- ��ü ������� ���, �����, �μ��ڵ� , �μ��� ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ������ ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT *
FROM JOB;

/*
    1. ����� (EQUAL JOIN) / �������� (INNER JOIN)
    �����ϰ��� �ϴ� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ�ż� ��ȸ => ��ġ�ϴ� ���� ���� ���� ��ȸ���� ����!

*/

-- >> ����Ŭ ���뱸��
-- FROM���� ��ȸ�ϰ��� �ϴ� ���̺���� ','�� �����ڷγ���
-- WHERE���� ��Ī��ų �÷�(�����)�� ���� ������ ������

-- 1) ���� �� �� �÷����� �ٸ� ��� (EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
-- ���, �����, �μ��ڵ�, �μ����� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵȰ� Ȯ�� ����
--> DEPT_CODE �� NULL�� ��� ��ȸX, DEPT_ID�� D3, D4, D7 ��ȸX

-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE : JOB_CODE, JOB : JOB_CODE)
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE;
-- column ambiguously defined ���� �߻�
-- ambiguously : �ָ��ϴ�, ��ȣ�ϴ�

-- �ذ���1) ���̺���� �̿��� ����ϴ� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- �ذ���2) ���̺� ��Ī�� �ο��ؼ� �̿��ϴ� ��� ***
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


SELECT *
FROM JOB;

-- >> ANSI ����
-- FROM���� ������ �Ǵ� ���̺��� �ϳ� ��� �� ��
-- JOIN���� ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� + ��Ī��ų �÷��� ���� ���� ���
-- JOING USING, JOIN ON

-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
-- ������ JOIN ON �������θ� ��� ����!!!
-- ���, �����, �μ��ڵ�, �μ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE : JOB_CODE, JOB : JOB_CODE)
-- JOIN ON, JOIN USING ���� ��� ����!
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON (JOB_CODE = JOB_CODE);
-- column ambiguously defined

-- �ذ���1) ���̺�� �Ǵ� ��Ī�� �̿��ؼ� ����ϴ� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- �ذ���2) JOIN USING ���� ����ϴ� ��� (�� �÷����� ��ġ�Ҷ��� ��� ����) ***
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

-- [�������]----------
-- �ڿ�����(NATURAL JOIN) : �� ���̺��� ������ �÷��� �� ���� ������ ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- �߰����� ���ǵ� ��� ���� ����
-- ������ �븮�� ����� �̸�, ���޸�, �޿� ��ȸ
-- >> ����Ŭ ���� ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '�븮';
--                            AND E.JOB_CODE = 'J6';

-- >> ANSI ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE --1
JOIN JOB USING (JOB_CODE) -- 2
WHERE JOB_NAME = '�븮'; -- 3

----------------------------------------------- �ǽ����� -----------------------------------------------------
-- 1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
-- >> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '�λ������';
-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';


-- 2. DEPARTMENT�� LOCATION�� �����ؼ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
-- >> ����Ŭ ���뱸��
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
-- >> ANSI ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);


-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-- >> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;
-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �μ��� ��ȸ
-- >> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_CODE AND DEPT_TITLE != '�ѹ���';
-- DEPT_ID, DEPT_TITLE
-- >> ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE DEPT_TITLE != '�ѹ���';
-- ���� ���� DEPT_CODE�� NULL �ΰ� ������ ���� ����! -> ������̶�

-----------------------------------------------------------------------------------------------------------

/*
    2, ���� ���� / �ܺ� ���� (OUTER JOIN)
    �� ���̺��� JOIN�� ��ġ�����ʴ� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT / RIGHT �����ؾߵ�!! �� ������ �Ǵ� ���̺��� �����ؾߵ�
*/

-- �����, �μ���, �޿�, ����
SELECT EMP_NAME, DEPT_TITLE, SALARY,SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- ���� �μ���ġ�� �ȵ� ��� 2�� ���� ������ ��ȸX
-- �μ��� ������ ����� ���� �μ� ���� ��쵵 ��ȸX

-- 1) LEFT [OUTER] JOIN : �� ���̺� �� ���� ����� ���̺� �������� JOIN
-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE -- EMPLOYEE�� �ִ°� ������ �� �����°���! 
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- �μ���ġ�� ���� �ʾҴ� 2���� ��� ������ ��ȸ��!

-->> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- �������� ������ϴ� ���̺��� �ݴ��� �÷��ڿ� (+) ���̱� 

-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- �����ִ� ����� ���� �μ��� �� ��ȸ��

-->> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;


-- 3) FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� ���� (��, ����Ŭ���뱸�����δ� �ȵ�)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- LEFT, RIGHT JOIN �� ��ģ ����


/*
    3. �� ���� (NON EQUAL JOIN) => ��� �׳� �����
    ��Ī��ų �÷��� ���� ���� �ۼ��� '=(��ȣ)'�� ������� �ʴ� ���ι�
    ANSI �������δ� JOIN ON �� ��� ����
    
*/

SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE;

SELECT * FROM SAL_GRADE;

-- �����, �޿�, �ִ� ���� �ѵ�
-- >> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- >> ANSI ����
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

----------------------------------------------------------------------------------------------------------------------

/*
    4. ��ü���� (SELF JOIN)
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
*/

SELECT * FROM EMPLOYEE;
-- MANAGER_ID = EMP_ID

-- ��ü����� ���, �����, ����μ��ڵ�,    => EMPLOYEE E
-- ����� ���, �����, ����μ��ڵ�         => EMPLOYEE M
-- >> ����Ŭ ���� ����
SELECT E.EMP_ID AS "������" , E.EMP_NAME AS "�����", E.DEPT_CODE AS "����μ��ڵ�", 
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE AS "����μ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

SELECT EMP_ID AS "������", EMP_NAME AS "�����", DEPT_CODE AS "����μ��ڵ�",
       EMP_ID AS "������

-- >> ANSI ����
SELECT E.EMP_ID AS "������" , E.EMP_NAME AS "�����", E.DEPT_CODE AS "����μ��ڵ�", 
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE AS "����μ��ڵ�"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;
-----------------------------------------------------------------------------------------------

/*
    < ���� JOIN >
    2�� �̻��� ���̺��� ������ JOIN �� ��
*/

-- ���, �����, �μ���, ���޸� ��ȸ
SELECT * FROM EMPLOYEE;   -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;        --            JOB_CODE

-- >> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);

-- ���, �����, �μ���, ������
SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE

-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;

-- > ANSI ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- �̷��Դ� �ȵ�! ó�� EMPLOYEE�� LOCATION�� ������ �ȵ�(����� ���� ��Ű��!!)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

---------------------------------- �ǽ����� ---------------------------------------

-- 1. ���, �����, �μ���, ������, ������ ��ȸ (EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL)
-- >> ����Ŭ ���� ����
SELECT * FROM EMPLOYEE; -- DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ ID, LOCATION_ID
SELECT * FROM NATIONAL; -- NATIONAL_CODE
SELECT * FROM LOCATION; --      ''        LOCAL_CODE

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME ,NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, NATIONAL N, LOCATION L
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE AND N.NATIONAL_CODE = L.NATIONAL_CODE;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME ,NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);

-- 2. ���, �����, �μ���, ���޸�, ������, ������, �ش� �޿���޿��� ���� �� �ִ� �ִ�ݾ� ��ȸ
-- >> ����Ŭ
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

