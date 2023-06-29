
/*
    * ��������(SUBQUERY)
    �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
    ���� SQL���� ���� ���� ������ �ϴ� ������
    
*/

-- ���� �������� ����1
-- ���ö ����� ���� �μ��� ���� ����� ��ȸ�ϰ� ����!

-- 1) ���� ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; -- D9

-- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--���� 2�ܰ踦 �ϳ��� ������
SELECT EMP_NAME --> ��������
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE --> �������� (�巡���ؼ� ���������� ���� ����)
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');

-- ���� �������� ����2
-- �� ������ ��ձ޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ

-- 1) �� ������ ��ձ޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE; -- �뷫������ 3047663��

-- 2) �޿��� 3047664�� �̻��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- ���� 2�ܰ踦 �ϳ��� ����������!!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM EMPLOYEE);

-------------------------------------------------------------------------------------

/*
    * ���������� ����
    �������� ������ ������� �� �� �� ���̳Ŀ� ���� �з���
    
    - ������ �������� : ���������� ��ȸ ������� ������ ������ 1���� �� , �� �� �� ��)
    - ������ �������� : ���������� ��ȸ ������� �������� �� (������ �� ��) => �������� ���ö
    - ���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� �������� �� (�� �� ���� ��)
    - ������ ���߿� �������� : ���������� ��ȸ ������� ������ �����÷��� �� (������ ������)
    
    >> �������� ������ ���� �������� �տ� �ٴ� �����ڰ� �޶���!
*/

/*
    1. ������ �������� (SINGLE ROW SUBQUERY)
    ���������� ��ȸ ������� ������ ������ 1���� �� (���� �ѿ�)
    �Ϲ� �� ������ ��� ����
    =, !=, ^=, <>, <, >, =<, => ...
*/

-- 1) �� ������ ��ձ޿����� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
--WHERE SALARY < �������� ��� �޿� 
WHERE SALARY < (SELECT AVG(SALARY) --> �������� : ������(1��1��) ��Һ� ����
                FROM EMPLOYEE);

-- 2) ���� �޿��� �޴� ����� ���, �̸�, �޿�, �Ի���
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
--WHERE SALARY = �������� �� �����޿�
WHERE SALARY = (SELECT MIN(SALARY) --> ������ : ����� ����
                FROM EMPLOYEE);

-- 3) ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE SALARY > ���ö ����� �޿�
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
-- ������������ JOIN�� ��� ��밡��
-- >> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND SALARY > (SELECT SALARY
                FROM EMPLOYEE
              WHERE EMP_NAME = '���ö');
-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
              WHERE EMP_NAME = '���ö');
              
              
-- 4) �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿� �� ��ȸ
-- 4-1) ���� �μ��� �޿��� �߿����� ���� ū �� �ϳ��� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE; --17700000

-- 4-2) �μ��� �޿����� 17700000���� �μ��� ��ȸ (�μ��ڵ�, �޿��� ��ȸ)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

-- ���� �� �ܰ踦 �ϳ��� ����������!
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);


-- �����غ���
-- ������ ����� ���� �μ����� ���, �����, ��ȭ��ȣ, �Ի���, �μ���
-- ��, �������� ����!
-- >> ����Ŭ���뱸��
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_CODE = (SELECT DEPT_CODE
                                            FROM EMPLOYEE
                                            WHERE EMP_NAME = '������')
    AND EMP_NAME != '������';

-- >> ANSI����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
      AND EMP_NAME != '������';
      
------------------------------------------------------------------------------------------------------------
/*
    2. ������ �������� (MULTI ROW SUBQUERY)
    ���������� ������ ������� ���� �� �϶� (�÷�(��)�� �Ѱ�)
    
    - IN �������� : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� �ִٸ�
    - > ANY �������� : �������� ����� �߿��� "�Ѱ���" Ŭ ��� (�������� ����� �߿��� ���� ���������� Ŭ ���)
    - < ANY �������� : �������� ����� �߿��� "�Ѱ���" ���� ��� (�������� ����� �߿��� ���� ū������ ���� ���)
    
    �񱳴�� > ANY (��1, ��2, ��3, ..)
    �񱳴�� > ��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3
    
    - > ALL �������� : �������� "���" ������� ���� Ŭ ���
    - < ALL �������� : �������� "���" ������� ���� ���� ���
    
    �񱳴�� > ALL (��1, ��2, ��3)
    �񱳴�� > ��1 AND �񱳴�� > ��2 AND �񱳴�� > ��3
    
*/

-- 1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿�
-- 1-1) ����� �Ǵ� ������ ����� � �������� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�����', '������'); -- J3, J7

-- 1-2) J3, J7�� ������ ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

-- ���� �� �ܰ踦 �ϳ��� ������
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
--WHERE JOB_CODE = (SELECT JOB_CODE --> '=' �����ڸ� ���� ������, ���������� ��ȸ�Ǳ⶧����!
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('�����', '������'));

-- ��� => �븮 => ���� => ���� => ���� ...
-- 2) �븮 �����ӿ��� �ұ��ϰ� ���� ���� �޿��� �� �ּ� �޿����� ���� �ٴ� ���� ��ȸ (���, �̸�, ����, �޿�)
-- 2-1) ���� ���� ������ ������� �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '����'; -- 2200000 2500000 3760000

-- 2-2) ������ �븮�̸鼭 �޿����� ���� ��ϵ� �� �߿� �ϳ��� ū ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
--AND SALARY > IN (2200000, 2500000, 3760000);
AND SALARY > ANY (2200000, 2500000, 3760000);

-- ���� �� �ܰ踦 �ϳ��� ���������� �ۼ�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (SELECT SALARY --> ���������� : IN���� ��Һ� �ȵ� -> > ANY �������� 
                    FROM EMPLOYEE E, JOB J
                    WHERE E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '����');

-- ������ ���������ε� ����!
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > (SELECT MIN(SALARY)
                    FROM EMPLOYEE E, JOB J
                    WHERE E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '����');

-- 3) ���� �����ӿ��� �ұ��ϰ� ���� ������ ��� �޿����ٵ� �� ���� �޴� �������
--    ���, �̸�, ���޸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����' 
--AND SALARY > ���� ������ �ֵ��� �޿���
AND SALARY > ALL (SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING (JOB_CODE)
                WHERE JOB_NAME = '����');
                
---------------------------------------------------------------------------------

/* 
    3. ���߿� ��������
    ������� �� �������� ������ �÷����� �������� ���
*/

-- 1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ
--    (�����, �μ��ڵ�, �����ڵ�, �Ի�����)
-- ������ �������� ** 2���� ���������� �ۼ�
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������') -- D5
AND JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������'); -- J5

-- >> ���߿� ��ũ������!
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
--WHERE (DEPT_CODE, JOB_CODE) = (������ ����� �μ��ڵ�, ������ ����� �����ڵ�);
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                              WHERE EMP_NAME = '������'); -- ���� �߿��ϰ� ������ �������!!
                              
-- �ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� �������
--���, �����, �����ڵ�, ������ ��ȸ
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '�ڳ���';

SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '�ڳ���');

------------------------------------------------------------------------------------------------------------

/*
    4. ������ ���߿� ��������
    �������� ��ȸ ������� ������ ������ �� ���
    
*/

-- 1) �� ���޺� �ּұ޿��� �޴� ��� ��ȸ (���, �����, �����ڵ�, �޿�)
-->> �� ���޺� �ּұ޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY) -- 3
FROM EMPLOYEE -- 1
GROUP BY JOB_CODE; -- 2

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
OR    JOB_CODE = 'J7' AND SALARY = 1380000
...;

-- ���������� �����ؼ� �غ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY) --> ������ ���߿�
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);

-- 2) �� �μ����� �ְ� �޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY) --> ������ ���߿�
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE)
ORDER BY 3;

-----------------------------------------------------------------------------------------------

/*
    5. �ζ��� �� (INLINE - VIEW)
    
    ���������� ������ ����� ��ġ ���̺� ó�� ���!
    
*/

-- ������� ���, �̸�, ���ʽ����� ����(��Ī�ο� : ����), �μ��ڵ� => ���ʽ� ���� ������ ���� NULL�� �ȳ�����
-- ��, ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ
SELECT EMP_NO, EMP_NAME, (SALARY * NVL(BONUS,0) + SALARY)*12 AS "����", DEPT_CODE
FROM EMPLOYEE
--WHERE ���� > 30000000;
WHERE (SALARY * NVL(BONUS,0) + SALARY)*12 > 30000000;

SELECT EMP_NO, EMP_NAME, (SALARY * NVL(BONUS,0) + SALARY)*12 AS "����", DEPT_CODE
FROM EMPLOYEE;
-- �̰� ��ġ �����ϴ� ���̺��ΰ� ���� ����� �� ����! �װ� �ζ��κ�

SELECT *
FROM (SELECT EMP_NO, EMP_NAME, (SALARY * NVL(BONUS,0) + SALARY)*12 AS "����", DEPT_CODE
FROM EMPLOYEE)-- 1
WHERE ���� >= 30000000;

SELECT EMP_NO, EMP_NAME, ����, DEPT_CODE--, MANAGER_ID; -- ���̺� ���� �÷�, ����
FROM (SELECT EMP_NO, EMP_NAME, (SALARY * NVL(BONUS,0) + SALARY)*12 AS "����", DEPT_CODE
FROM EMPLOYEE)-- 1
WHERE ���� >= 30000000;

-- >> �ζ��� �並 �ַ� ����ϴ� �� => TOP-N �м� (���� ��� �����ְ� ���� �� -> BEST ��ǰ!)

-- �� ���� �� �޿��� ���� ���� ���� 5�� ��ȸ
-- * ROWNUM : ����Ŭ �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�

SELECT ROWNUM, EMP_NAME, SALARY --2
FROM EMPLOYEE --1
ORDER BY SALARY DESC;
-- ������ �̻��� -> ������� ����
-- �����ϰ� ������ �ű������� ��������� ORDER BY���� �������̶� ������ �̻���
-- FROM -> SELECT ROWNUM (�̶� ���� �ο���, ���ĵ� �ϱ����� �̹� ������ �ο�)

SELECT ROWNUM, EMP_NAME, SALARY --2
FROM EMPLOYEE --1
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
--> ���������� ��� ��ȸX (������ �Ǳ⵵ ���� 5���� �߷������� �����̵ż�!)

-- ORDER BY ���� �� ����� ����� ������ ROWNUM�� �ο� �� 5���� �߷�����!!
SELECT EMP_NAME, SALARY, DEPT_CODE -- 2
FROM EMPLOYEE -- 1
ORDER BY SALARY DESC; -- 3

SELECT ROWNUM, * --EMP_NAME, SALARY -- 3
FROM (SELECT * --EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
    ORDER BY SALARY DESC) -- 1
WHERE ROWNUM <= 5; -- 2
 
-- ROWNUM �̶� ��ü�÷� ��ȸ�ϰ� ���� => ��Ī �ο� �ϴ� �������
SELECT ROWNUM, E.* --EMP_NAME, SALARY -- 3
FROM (SELECT * --EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
    ORDER BY SALARY DESC) E -- 1
WHERE ROWNUM <= 5; -- 2

-- ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ(�����, �޿�, �Ի���)
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT ROWNUM, EMP_NAME, SALARY, HIRE_DATE
FROM (SELECT *
        FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;

-- �� �μ��� ��ձ޿��� ���� 3���� �μ� ��ȸ (�μ��ڵ�, ��ձ޿�)
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 2 DESC;

SELECT /*ROWNUM*/, DEPT_CODE, ROUND(��ձ޿�) -- SELECT������ ROWNUM ��������
FROM (SELECT DEPT_CODE, AVG(SALARY) AS "��ձ޿�"
        FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY 2 DESC)
WHERE ROWNUM <= 3;

--------------------------------------------------------------------------------------------
/*
     * ���� �ű�� �Լ� (WINDOW FUNCTION)
            RANK() OVER(���ı���)                    DENSE_RANK() OVER(���ı���)

    - RANK() OVER(���ı���) : ������ ���� ������ ����� ������ �ο��� ��ŭ �ǳʶٰ� ���� ���
                            EX) ����1���� 2�� �� ���� ������ 3�� => 1, 1, 3
    - DENSE_RANK() OVER(���ı���) : ������ ������ �ִٰ� �ص� �� ���� ����� ������ 1�� ���� ��Ŵ
                            EX) ���� 1���� 2���̴��� �� ���� ������ 2�� => 1, 1, 2
    >> �� �Լ��� ������ SELECT�������� ��� ����!!
    
*/

-- �޿��� ���� ����� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
-- ���� 19�� 2�� �� ���� ������ 21 => ������ ������ ��ȸ�� ����� ����

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
-- ���� 19�� 2�� �� ���� ������ 20 => ������ ������ ��ȸ�� ����� �ٸ�

-- ���� 5�� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5; -- ��ũ �Լ� ������ SELECT��������
--ORDER BY 3;

-- �ζ��κ並 �� �� �ۿ� ����!
SELECT *
FROM(SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "����"
        FROM EMPLOYEE)
WHERE ���� <=5;














