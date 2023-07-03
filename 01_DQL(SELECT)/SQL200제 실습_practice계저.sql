


-- 1. ��� ���̺��� ��翭 ���
SELECT * FROM EMP;

-- 2. ������̺��� �����ȣ, �̸�, ���� ��� (��Ī ���)
SELECT EMPNO AS "�����ȣ", ENAME AS "�̸�" , SAL AS "����"
FROM EMP;

-- 3. ������̺��� �̸��� ������ ���� �ٿ��� ��� (��¿��� ) KING5000)
SELECT ENAME || SAL
FROM EMP;

-- 4. ������̺��� �̸��� ������ ���� �ٿ��� ��� (��¿���) KING�� ������ 5000�Դϴ�.)
SELECT ENAME || '�� ������ ' || SAL || '�Դϴ�'
FROM EMP;

-- 5. ������̺��� �̸��� ������ ���� �ٿ��� ��� (��¿���) KING�� ������ PRESIDENT �Դϴ�.)
SELECT ENAME || '�� ������ ' || JOB || ' �Դϴ�.'
FROM EMP;

-- 6. ������̺��� ������ ����ϴµ� �ߺ��� �����͸� �����ϰ� ����غ��� (�ΰ��� ����)
-- �Ѱ��� ����� �����ð��� ������, �ٸ������ �����ð��� ���� => �˻��ؼ� ã�ƺ��� 
SELECT DISTINCT JOB
FROM EMP;

-- 7. �̸��� ������ ����ϴµ� ������ ���� ������� ���  
-- 7-1. ��Ī������ ���� ����
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL;

-- 7_2. ��Ī���ι��� (ORDER BY ����)
SELECT ENAME, SAL AS "����"
FROM EMP
ORDER BY ����;

-- 7_3. �÷������� ������ ����
SELECT ENAME, SAL
FROM EMP
ORDER BY 2;

-- 8. ������ 3000�� ����� �̸���, ����, ���� ���
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL = 3000;

-- 9. ������ 3000�̻��� ����� �̸���, ����, ���� ���
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL >= 3000;

-- 10. �̸��� SCOTT�� ����� �̸�, ����, ����, �Ի���, �μ���ȣ ���
SELECT * FROM EMP;

SELECT ENAME, SAL, JOB, HIREDATE, DEPTNO
FROM EMP
WHERE ENAME = 'SCOTT';

-- 11. ������ 3600 �̻��� ������� �̸��� ���� ���
-- ����(?) ����(?)
SELECT ENAME, SAL * 12 AS "����"
FROM EMP
WHERE SAL*12 >= 3600;

-- 12. �μ���ȣ�� 10���� ������� �̸�, ����, Ŀ�̼�, ���� + Ŀ�̼� ���
SELECT ENAME, SAL, COMM, SAL + NVL(COMM,0)
FROM EMP
WHERE DEPTNO = 10;

-- 13. ������ 1000���� 3000 ������ ������� �̸��� ���� ��� (�񱳿�����, BETWEEN AND ���� �ΰ��� ���� �� �ۼ�)
SELECT ENAME, SAL
FROM EMP
WHERE SAL BETWEEN 1000 AND 3000;

SELECT ENAME, SAL
FROM EMP
WHERE SAL >= 1000 AND SAL <= 3000;

-- 14. �̸��� ù���ڰ� S�� �����ϴ� ������� �̸��� ���� ���
SELECT ENAME, SAL
FROM EMP
WHERE ENAME LIKE 'S%';

-- 15. �̸��� �ι�° ö�ڰ� M�� ����� �̸��� ���
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '_M%';

-- 16. �̸��� �� ���ڰ� T�� ������ ������� �̸��� ���
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%T';

-- 17. �̸��� A�� �����ϰ� �ִ� ������� �̸� ���
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%A%';

-- 18. Ŀ�̼��� NULL�� ������� �̸��� Ŀ�̼� ���
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NULL;

-- 19. ������ SALESMAN, ANALYST, MANAGER�� ������� �̸�, ����,���� ��� => (OR, IN ��� �ΰ�����������)
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB IN ('SALESMAN', 'ANALYST', 'MANAGER');

SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB = 'SALAESMAN' OR JOB = 'ANALYST' OR JOB = 'MANAGER';

-- 20. ������ SALESMAN�̰� ������ 1200 �̻��� ������� �̸�, ����, ���� ���
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB = 'SALESMAN' AND SAL >= 1200;

-- 21. ������̺��� �̸� ��½� ù��° �÷��� �̸��� �빮�ڷ� ����ϰ�, �ι�° �÷��� �̸��� �ҹ��ڷ� ����ϰ�, ����° �÷��� �̸��� ù ��° ö�ڴ� �빮�ڷ� �ϰ� �������� �ҹ��ڷ� ���
SELECT UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

-- 22. �̸��� soctt �� ����� �̸��� ������ ��ȸ�ϴ� ���� => where���� scott ���ڸ� �ҹ��ڷ� �ۼ��� ��! 1�� ���;���
SELECT ENAME, SAL
FROM EMP
WHERE LOWER(ENAME) = 'scott';

-- 23. ����ܾ� SMITH���� SMI�� �߶� ����
SELECT SUBSTR('SMITH', 1, 3)
FROM DUAL;

-- 24. ������� �̸��� �̸��� ö�ڰ����� ���
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

-- 25. �����ٶ� �� ���ڼ� ���
SELECT LENGTH('�����ٶ�') FROM DUAL;

-- 26. �����ٶ��� ����Ʈ �� ���
SELECT LENGTHB('�����ٶ�') FROM DUAL;

-- 27. ����̸� SMITH���� ���ĺ� ö�� M�� ���° �ڸ��� �ִ��� ���
SELECT INSTR(ENAME, 'M') 
FROM EMP
WHERE ENAME = 'SMITH';

-- 28. abcdefg@naver.com �̸��Ͽ��� naver.com�� ��� (INSTR , SUBSTR �ΰ��� ����)
SELECT SUBSTR('abcdefg@naver.com', 9) FROM DUAL;
SELECT SUBSTR('abcdefg@naver.com', INSTR('abcdefg@naver.com','naver')) FROM DUAL;

-- 29. �̸��� ������ ����ϴµ�, ������ ����� �� ���� 0�� *(��ǥ)�� ��� (KING, 5***) 
SELECT ENAME, RPAD(SUBSTR(SAL,1,1), LENGTH(SAL), '*')
FROM EMP;

-- 30. TEST_ENAME �̶�� ���̺� ���� (�÷� 1�� : ENAME VARCHAR2(10) )
CREATE TABLE TEST_ENAME(
    ENAME VARCHAR2(10)
);

-- 31. TEST_ENAME �̶�� ���̺� 3���� ���õ����� �ֱ� (��ÿ�, ������, ������)
INSERT INTO TEST_ENAME VALUES ('��ÿ�');
INSERT INTO TEST_ENAME VALUES ('������');
INSERT INTO TEST_ENAME VALUES ('������');

SELECT * FROM TEST_ENAME;
-- 32. COMMIT; ����
COMMIT;

-- 33. �̸��� �ι�° �ڸ��� �ѱ��� *�� ��� (��*��, ��*��, ��*��)
SELECT REPLACE(ENAME, SUBSTR(ENAME,2,1),'*')
FROM TEST_ENAME;

-- 34. �̸��� ������ ����ϴµ� �����÷��� �ڸ����� 10�ڸ��� �Ͽ� ���� ����ϰ�, �����ڸ��� *�� ä���� ���
SELECT ENAME, LPAD(SAL, 10,'*') FROM EMP;

-- 35. ù��° �÷��� smith ö�ڸ� ����ϰ�, �ι�° �÷��� ����ܾ� smith���� s�� �߶� ����ϰ�, ����° �÷��� smith���� h�߶� ����ϰ�
--     �׹�° �÷��� ����ܾ� smiths�� ���� s�� �����Ͽ� ��� ( smith, mith, smit, mith ) =>  ����� �Լ� Ȱ��
SELECT 'smith', LTRIM('smith','s'), RTRIM('smith', 'h'), TRIM('s' FROM 'smiths')
FROM DUAL;

-- 36. �̸��� JACK�� ����� �̸��� ������ ��ȸ = >�ȳ���.. �־ȳ��ñ�? ���������� => ������ ��� 
SELECT ENAME, SAL
FROM EMP
WHERE TRIM(ENAME) = 'JACK';

-- 37. 876.567 ���� ��½� �Ҽ��� �� ��° �ڸ��� 6���� �ݿø��ؼ� ���
SELECT ROUND(876.567,2)
FROM DUAL;

-- 38. 876.567 ���� ��½� �Ҽ��� �� ��° �ڸ��� 6�� �� ������ ���ڵ��� ��� ������ ���
SELECT TRUNC(876.567, 1) FROM DUAL;

-- 39. ���� 10�� 3���� ���� �������� ���ϱ�
SELECT MOD(10,3) FROM DUAL;

-- 40. �̸��� ����ϰ� �Ի��� ��¥���� ���ñ��� �� ����� �ٹ��ߴ��� ���
SELECT ENAME, FLOOR(MONTHS_BETWEEN(SYSDATE, HIREDATE))
FROM EMP;

-- 50. 2023�� 6�� 30�Ϸκ��� 100�� ���� ��¥�� ��� �Ǵ��� ���
SELECT ADD_MONTHS('23/06/30', 100) FROM DUAL;

-- 51. 2023�� 1�� 1�� ���� �ٷ� ���ƿ� �������� ��¥�� ��� �Ǵ��� ���
SELECT NEXT_DAY('23/01/01', '��') FROM DUAL;

-- 52. ���ú��� ������ ���ƿ� ȭ������ ��¥�� ���
SELECT NEXT_DAY(SYSDATE, 'ȭ') FROM DUAL;

-- 53. ���ú��� 100�� �ڿ� ���ƿ��� �������� ��¥�� ���
SELECT NEXT_DAY(ADD_MONTHS(SYSDATE, 100),'��') FROM DUAL;

-- 54. 1990�� 5�� 22�� �ش� ���� ������ ��¥�� ��� �Ǵ��� ���
SELECT LAST_DAY('1990/05/20') FROM DUAL;

-- 55. ���ú��� �̹��� ���ϱ��� �� ��ĥ ���Ҵ��� ���
SELECT LAST_DAY(SYSDATE) - SYSDATE FROM DUAL;

-- 56. �̸��� KING�� ����� �̸�, �Ի���, �Ի��� ���� ������ ��¥ ���
SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE)
FROM EMP
WHERE ENAME = 'KING';

-- 57. �̸��� SCOTT�� ����� �̸��� �Ի��� ������ ����ϰ� SCOTT�� ���޿� õ ������ ������ �� �ִ� �޸�(,) �ٿ��� ���
SELECT ENAME, TO_CHAR(HIREDATE, 'DAY'),TO_CHAR(SAL, '9,999')
FROM EMP
WHERE ENAME = 'SCOTT';

-- 58. 1981�⵵�� �Ի��� ����� �̸��� �Ի��� ��� => TO_CHAR �̿��Ͽ�
SELECT ENAME, HIREDATE
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981';

-- 59. ��ü����� �̸���, �Ի翬��, �Ի��, �Ի���� ���
SELECT ENAME AS "�̸�", HIREDATE AS "�Ի翬��", TO_CHAR(HIREDATE, 'MON') AS "�Ի��", TO_CHAR(HIREDATE, 'DAY') AS "�Ի����"
FROM EMP;

-- 60. ��ü����� �̸���, ����*200 ��� => �޸���
SELECT ENAME, TO_CHAR(SAL * 200, '9,999,999')
FROM EMP;

-- 61. ���� �������ٰ� ��ȭ�ٿ��� ���
SELECT ENAME, TO_CHAR(SAL * 200, 'L9,999,999')
FROM EMP;

-- 62. �̸��� Ŀ�̼� ���. Ŀ�̼� NULL�� ��� 0���� ���
SELECT ENAME, NVL(COMM, 0)
FROM EMP;

-- 63. �����ȣ�� �����ȣ�� ¦������ Ȧ������ ��� (7839, Ȧ��)
SELECT * FROM EMP;
SELECT EMPNO, DECODE(MOD(EMPNO,2), 1, 'Ȧ��', 0, '¦��')
FROM EMP;

-- 64. ����� �̸��� ������ ���ʽ��� ���. ������ SALESMAN�̸� ���ʽ��� 5000�̶�� ����ϰ� �� �ܴ� 2000�̶�� ��� 
SELECT ENAME, JOB, DECODE(JOB, 'SALESMAN', 5000, 2000) AS "BONUS"
FROM EMP;

-- 65. �̸�, ����,����, ���ʽ� ���. ���ʽ��� ������ 3000�̻��̸� 500. 2000�̻�~3000 ���� ������ 300. 
--    ������ 1000�̻�~2000 ���� ������ 200 �������� 0 => CASE WHEN THEN ����
SELECT ENAME, JOB, SAL, 
       CASE WHEN SAL >= 3000 THEN 500
            WHEN SAL >= 2000 AND SAL < 3000 THEN 300
            WHEN SAL >= 1000 AND SAL < 2000 THEN 200
            ELSE 0
        END AS "BONUS"
FROM EMP;
       
-- 66. ������ SALESMAN�� ����� �� �ִ���� ���
SELECT MAX(SAL)
FROM EMP
WHERE JOB = 'SALESMAN';

-- 67. �� �μ��� �ִ� �޿� ���
SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

-- 68. ����, ������ �ּ� ���� ���. ��, SALESMAN�� �����ϰ�, ������ �ּҿ����� ������ ���� ���
SELECT JOB, MIN(SAL)
FROM EMP
GROUP BY JOB
HAVING JOB != 'SALESMAN'
ORDER BY 2 DESC;

-- 69. ������ ������ ������ ������ ���. ��, SALESMAN�� �����ϰ�,  �ѿ����� 4000 �̻��� ������ ���
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING JOB != 'SALESMAN' AND SUM(SAL) >= 4000;

SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB;

-- 70. ������ ANALYST, MANAGER �� ������� �̸�, ����, ����, ������ ���� ��� (1���� 2���Ͻ� ������ �ٷ� 3��)
SELECT ENAME, JOB, SAL, RANK() OVER(ORDER BY SAL DESC) AS "����"
FROM EMP
WHERE JOB IN ('ANALYST', 'MANAGER');

-- 71. ������ ANALYST, MANAGER �� ������� �̸�, ����, ����, ������ ���� ��� (1���� 2���Ͻ� ������ �ٷ� 2��)
SELECT ENAME, JOB, SAL, DENSE_RANK() OVER(ORDER BY SAL DESC) AS "����"
FROM EMP
WHERE JOB IN ('ANALYST', 'MANAGER');

-- 72. ������̺��� �����ȣ, �̸�, ����, ������ ���. ��, ���޳��� ���� 5���� �ุ ���
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
ORDER BY SAL DESC;

SELECT EMPNO, ENAME, JOB, SAL
FROM (SELECT EMPNO, ENAME, JOB, SAL
        FROM EMP
        ORDER BY SAL DESC)
WHERE ROWNUM <= 5;

-- 73. ������̺�� �޿����̺��� �����Ͽ� �����, �޿�, �޿���� ��� (ANSI, ORACLE)
SELECT * FROM EMP; 
SELECT * FROM SALGRADE;

SELECT ENAME, SAL, GRADE
FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL;

SELECT ENAME, SAL, GRADE
FROM EMP
JOIN SALGRADE ON (SAL BETWEEN LOSAL AND HISAL);

-- 74. ������̺�� �μ����̺��� �����Ͽ� �̸��� �μ���ġ ���(��, BOSTON �� ���� ��µǰ� �غ� ��)(ANSI, ORACLE)
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT ENAME, LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

SELECT ENAME, LOC
FROM EMP
RIGHT JOIN DEPT USING (DEPTNO);

-- 75. ��� ���̺��� �������� �Ͽ� �̸�, ����, �ش����� ������ �̸��� �������� ���� ���(ANSI, ORACLE)
SELECT * FROM EMP;

SELECT E.ENAME, E.JOB, M.ENAME AS "�������̸�", M.JOB AS "����������"
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO;

SELECT E.ENAME, E.JOB, M.ENAME AS "�������̸�", M.JOB AS "����������"
FROM EMP E
JOIN EMP M ON (E.MGR = M.EMPNO);

-- 76. ������̺�� �μ����̺� �����Ͽ� �̸�, ����,����,�μ���ġ ���
--    (��, ����� JACK�� �����Ϳ� �μ���ġ BOSTON�� ������ �Ѵ� ���;���)
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT ENAME, JOB, SAL, LOC
FROM EMP
RIGHT JOIN DEPT USING (DEPTNO);

