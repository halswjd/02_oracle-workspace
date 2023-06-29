----------------------[Basic SELECT]-----------------------------

--1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭"���� ǥ���ϵ��� �Ѵ�.
SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY AS "�迭"
FROM TB_DEPARTMENT;

--2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�' AS "�а��� ����"
FROM TB_DEPARTMENT;

--3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�̵��Դ�. 
--�����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�ã�� ������ ����)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_SSN,8,1) IN ('2','4') AND DEPARTMENT_NO = '001' AND ABSENCE_YN = 'Y';

--4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� �Ѵ�.
--�� ����ڵ����й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
--A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

--5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

--6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.
--�׷� �������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.
--��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT *
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8. ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

--10. 02 �й� ���� �����ڵ��� ������ ������� ����. ������ ������� ������ ��������
--�л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS,1,2)='����' AND ABSENCE_YN = 'N'
AND EXTRACT(YEAR FROM ENTRANCE_DATE)=2002;


---------------------- [Additional SELECT - �Լ�] ------------------------------
--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� ����.)
SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�", ENTRANCE_DATE AS "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

--2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����.
--�� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL
--������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

--3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
--�� �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�.
--(��, ���� �� 2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� ���������� �������.)
SELECT PROFESSOR_NAME,  - TO_DATE('19'||SUBSTR(PROFESSOR_SSN,1,6),'YYYYMMDD')
FROM TB_PROFESSOR
ORDER BY 2;

SELECT (SYSDATE-TO_DATE(SUBSTR(PROFESSOR_SSN,1,6)-'19000000'))
FROM TB_PROFESSOR;

--4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
--��� ����� "�̸�"�� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT SUBSTR(PROFESSOR_NAME,2) AS "�̸�"
FROM TB_PROFESSOR;

--5. �� ������б��� ����� �����ڸ� ���Ϸ��� ����. ��� ã�Ƴ� ���ΰ�?
--�̶�, 19 �쿡 �����ϸ� ����� ���� ���� ������ �A������.
SELECT *
FROM tb_student
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6))) > 19;

--6. 2020 �� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE(201225), 'DAY')
FROM DUAL;

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ����
--�� �� ��� �� ���� �ǹ�����? �� TO_DATE('99/10/11','RR/MM/DD'),
--TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����?
SELECT EXTRACT(YEAR FROM TO_DATE('99/10/11','YY/MM/DD'))"��", EXTRACT(MONTH FROM TO_DATE('99/10/11','YY/MM/DD'))"��",
       EXTRACT(YEAR FROM TO_DATE('49/10/11','YY/MM/DD'))"��", EXTRACT(MONTH FROM TO_DATE('49/10/11','YY/MM/DD'))"��"
FROM DUAL;

SELECT EXTRACT(YEAR FROM TO_DATE('99/10/11','RR/MM/DD'))"��", EXTRACT(MONTH FROM TO_DATE('99/10/11','YY/MM/DD'))"��",
       EXTRACT(YEAR FROM TO_DATE('49/10/11','RR/MM/DD'))"��", EXTRACT(MONTH FROM TO_DATE('49/10/11','YY/MM/DD'))"��"
FROM DUAL;

--8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�.
--2000 �⵵ �̠� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

--9. �й��� A517178 �� ���Ƹ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
--��, �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� �ڸ������� ǥ������.
SELECT ROUND(AVG(POINT),1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� �����
--���������µǵ��� �Ͻÿ�.
SELECT DEPARTMENT_NO AS "�а���ȣ", COUNT(*) AS "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

--11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
--��,�̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�,
--������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ������.
SELECT SUBSTR(TERM_NO,1,4) AS "�⵵", ROUND(AVG(POINT),1) AS "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

--13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�
SELECT DEPARTMENT_NO, NVL(SUM(DECODE(ABSENCE_YN, 'Y',1)),0)
FROM TB_STUDENT
--WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;
--HAVING ABSENCE_YN = 'Y';

--14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����.
--� SQL ������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;

--15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , ��
--������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
--ǥ������.)
SELECT SUBSTR(TERM_NO,1,4) AS "�⵵", SUBSTR(TERM_NO,5,2) AS "�б�", AVG(POINT) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(TERM_NO)
ORDER BY TERM_NO;

SELECT TERM_NO
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY EXTRACT(YEAR FROM TERM_NO);
/*
SELECT SUBSTR(TERM_NO,1,4) AS "�⵵", SUBSTR(TERM_NO,5,2) AS "�б�", ROUND(AVG(POINT),1) AS "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;
*/

------------------------[Additional SELECT - Option]------------------------
--1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
--������ �̸����� �������� ǥ���ϵ��� ����.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

--2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
--ORDER BY EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD')) DESC,
--         EXTRACT(MONTH FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD')) DESC
ORDER BY TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD') DESC;

--3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�,
--�ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�",
--"������ �ּ�" �� ��µǵ��� ����.
SELECT *
FROM TB_STUDENT
WHERE 












