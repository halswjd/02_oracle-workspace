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
SELECT PROFESSOR_NAME AS "�����̸�", EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM TO_DATE('19'||SUBSTR(PROFESSOR_SSN,1,6),'YYYYMMDD')) AS "����"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
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
SELECT STUDENT_NAME AS "�л� �̸�" , STUDENT_ADDRESS AS "�ּ���"
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
SELECT * FROM TB_STUDENT
ORDER BY STUDENT_ADDRESS;

SELECT STUDENT_NAME AS "�л��̸�" , STUDENT_NO AS "�й�", STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS, 1, 2) IN ('���', '����')
AND EXTRACT(YEAR FROM ENTRANCE_DATE) BETWEEN 1990 AND 1999
ORDER BY STUDENT_NAME;

--4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������
--�ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã��
--������ ����)
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_DEPARTMENT;

SELECT PROFESSOR_NAME, PROFESSOR_SSN, EXTRACT(YEAR FROM SYSDATE) - ('19'||SUBSTR(PROFESSOR_SSN,1,2))
FROM TB_PROFESSOR;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���а�'
ORDER BY 2;

--5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������
--���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������
--�ۼ��غ��ÿ�.
SELECT * FROM TB_GRADE;

SELECT STUDENT_NO, TO_CHAR(POINT, '9.99') AS "POINT"
FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;


--6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL 
--���� �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_DEPARTMENT;

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;


--7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_CLASS; -- CLASS_NAME, CLASS_NO, DEPARTMENT_NAME
SELECT * FROM TB_DEPARTMENT;

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

--8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ����
--�ۼ��Ͻÿ�.
SELECT * FROM TB_PROFESSOR; -- PROFESSOR_NO, 
SELECT * FROM TB_CLASS_PROFESSOR; -- CLASS_NO, PROFESSOR_NO
SELECT * FROM TB_CLASS;

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_PROFESSOR USING (PROFESSOR_NO)
ORDER BY 2;
-- ORDER BY DEPARTMENT_NO, PROFESSOR_SSN, CLASS_TYPE DESC, CLASS_NO;

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR USING (PROFESSOR_NO)
ORDER BY C.DEPARTMENT_NO, PROFESSOR_SSN, CLASS_TYPE DESC, CLASS_NO;

--9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿�
--�ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR P USING (PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '�ι���ȸ';
--ORDER BY C.DEPARTMENT_NO, PROFESSOR_SSN, CLASS_TYPE DESC, CLASS_NO;

SELECT * FROM TB_DEPARTMENT; -- CATEGORY
SELECT * FROM TB_CLASS;

--10. �������а��� �л����� ������ ���Ϸ��� ����. �����а� �л����� "�й�", "�л� �̸�", 
--"��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ�������
--�ݿø��Ͽ� ǥ������.)
SELECT * FROM TB_GRADE; -- STUDENT_NO, POINT
SELECT * FROM TB_STUDENT; -- STUDENT_NAME, DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT;-- DEPARTMENT_NO, DEPARTMENT_NAME


SELECT STUDENT_NO, STUDENT_NAME, ROUND(AVG(POINT),1)
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '�����а�'
GROUP BY STUDENT_NO, STUDENT_NAME;


--11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ�
--���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ����
--�ۼ��Ͻÿ�. ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?����
--��µǵ��� ����.
SELECT * FROM TB_STUDENT; -- COACH_PROFESSOR_NO
SELECT * FROM TB_PROFESSOR; -- PROFESSOR_NO
SELECT * FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NAME AS "�а��̸�", STUDENT_NAME AS "�л��̸�" , PROFESSOR_NAME AS "���������̸�"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

--12. 2007 �⵵�� '�΁A�����' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT STUDENT_NAME, TERM_NO
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE SUBSTR(TERM_NO,1,4) = '2007' AND CLASS_NAME = '�ΰ������';


--13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ����
--�̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_CLASS; -- DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT WHERE CATEGORY = '��ü��';

SELECT CLASS_NAME FROM TB_CLASS WHERE DEPARTMENT_NO IN (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE CATEGORY = '��ü��');

SELECT * FROM TB_CLASS;
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_DEPARTMENT; -- DEPARTMENT_NAME

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
WHERE PROFESSOR_NO IS NULL AND CATEGORY = '��ü��';

--14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸���
--�������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?����
--ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��, �������� ?�л��̸�?, ?��������?��
--ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� ����

SELECT * FROM TB_STUDENT; -- COACH_PROFESSOR_NO
SELECT * FROM TB_PROFESSOR; -- PROFESSOR_NO
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE; -- CLASS_NO, TERM_NO, STUDENT_NO
SELECT * FROM TB_CLASS; -- CLASS_NAME, CLASS_NO

SELECT STUDENT_NAME AS "�л��̸�" , NVL(PROFESSOR_NAME, '�������� ������') AS "��������"
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���ݾƾ��а�';


--15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а�
--�̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_GRADE;

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME, AVG(POINT)
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0;
--WHERE ABSENCE_YN = 'N';


--16. �Q�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_CLASS;
SELECT * FROM TB_DEPARTMENT;

SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_STUDENT S
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = 'ȯ�������а�' AND SUBSTR(CLASS_TYPE, 1, 2) = '����'
GROUP BY CLASS_NO, CLASS_NAME;

--17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ�
--SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_STUDENT WHERE STUDENT_NAME = '�ְ���');

--18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ����
--�ۼ��Ͻÿ�.

SELECT STUDENT_NAME, STUDENT_NO, AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '������а�')
GROUP BY STUDENT_NAME, STUDENT_NO
ORDER BY 3;

SELECT STUDENT_NAME, STUDENT_NO, RANK() OVER(ORDER BY AVG(POINT) DESC)
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NAME = '������а�'
GROUP BY STUDENT_NAME, STUDENT_NO;
--ORDER BY 3 DESC;

SELECT STUDENT_NO, STUDENT_NAME
FROM(SELECT STUDENT_NAME, STUDENT_NO, RANK() OVER(ORDER BY AVG(POINT) DESC) AS "����"
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    JOIN TB_GRADE USING (STUDENT_NO)
    WHERE DEPARTMENT_NAME = '������а�'
    GROUP BY STUDENT_NAME, STUDENT_NO)
WHERE ���� = 1;


--19. �� ������б��� "�Q�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������
--�ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. ��, �������� "�迭 �а���", 
--"��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ�������.

SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE; -- CLASS_NO
SELECT * FROM TB_CLASS; -- CLASS_NO

SELECT DEPARTMENT_NAME
FROM TB_DEPARTMENT
WHERE CATEGORY = (SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = 'ȯ�������а�');

SELECT DEPARTMENT_NAME AS "�迭 �а���", ROUND(AVG(POINT),1) AS "��������"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = 'ȯ�������а�')
GROUP BY DEPARTMENT_NAME;


---------------------------[DDL]-----------------------------------------

-- 1.
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

-- 2.
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

-- 3.
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);

-- 4.
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

-- 5.
ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR2(10)
MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR2(20);

-- 6. 
ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;
-- RENAME������ ���� �ȵǳ�...?

-- 7.
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CATEGORY
RENAME CONSTRAINT SYS_C007140 TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINT SYS_C007046 TO PK_CLASS_TYPE_NO;

-- 8.
INSERT INTO TB_CATEGORY VALUES ('����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��', 'Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ', 'Y');
COMMIT;
SELECT * FROM TB_CATEGORY;

-- 9.
ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY;


