-- ����
/*
    < �Լ� FUNCTION >
    ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ��
    
    - ������ �Լ� : N���� ���� �о�鿩�� N���� ������� ���� (�� �� ���� �Լ� ���� ��� ��ȯ)
    - �׷� �Լ� : N���� ���� �о�鿩�� 1���� ������� ���� (�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    >> SELECT ���� ������ �Լ�, �׷� �Լ��� �Բ� ��� ����
    ��? ��� ���� ������ �ٸ��� ����
    
    >> �Լ����� ��� �� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
    
*/

/*
    < ���� ó�� �Լ� >
    * LENGTH / LENGTHB      => ����� NUMBER Ÿ��
    
    LENGTH(�÷�|'���ڿ���') : �ش� ���ڿ� ���� ���ڼ� ��ȯ
    LENGTHB(�÷�|'���ڿ���') : �ش� ���ڿ� ���� ����Ʈ �� ��ȯ
    
    '��', '��', '��' �� ���ڴ� 3����Ʈ
    ������, ����, Ư�� �� ���ڴ� 1����Ʈ
*/

SELECT SYSDATE -- ���� ��¥ ��ȸ
FROM DUAL; -- DUAL => ���� ���̺�, ���̺� �� �� ���� �� ���� ��!

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL),LENGTB(EMAIL)
FROM EMPLOYEE; -- ���ึ�� �� ����ǰ� ����! => ������ �Լ�


/*
    * INSTR
    ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷�|'���ڿ�', 'ã�����ϴ� ����', ['ã����ġ�� ���۰�', [����]]) => ������� NUMBER Ÿ��!!
    
    ã�� ��ġ�� ���۰�
    1 : �տ������� ã�ڴ�.
    -1 : �ڿ������� ã�ڴ�.
    
*/

SELECT INSTR('AABAACAABBAA', 'B') -- ã�� ��ġ�� ���۰��� 1 => �⺻�� : �տ������� ã��, ������ �⺻��
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1)
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1, 2)
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1, 3)
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_��ġ", INSTR(EMAIL, '@') AS "@��ġ"
FROM EMPLOYEE;

----------------------------------------------------------------------------------------

/*
    * SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ (�ڹٿ��� substring() �޼ҵ�� ����)
    
    SUBSTR(STRING, POSTION, [LENGTH])   => ������� CHARACTER Ÿ��
    - STRING : ����Ÿ���÷� �Ǵ� '���ڿ���'
    - POSITION : ���ڿ��� ������ ���� ��ġ��
    - LENGTH : ������ ���� ���� (������ ������ �ǹ�)
    
 */

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE;

-- ���� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- ���� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1,3) -- ����Ŭ�� ���������� �ڵ� ����ȯ 
ORDER BY 1; -- �⺻������ ��������


-- �Լ� ��ø ���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1,INSTR(EMAIL, '@')-1) AS "���̵�" 
FROM EMPLOYEE;

----------------------------------------------------------------------------

/*
    * LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
    
    LPAD / RPAD (STRING, ���������� ��ȯ�� ������ ����, [�����̰����ϴ� ����])
    
    ���ڿ��� �� ���̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���� ��ŭ�� ���ڿ��� ��ȯ
    
*/

SELECT EMP_NAME, RPAD(EMAIL, 20) -- �����̰��� �ϴ� ���� ������ �⺻���� ����
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

--SELECT EMP_NAME, RPAD(�ֹι�ȣ������ �����ڸ����� ������ ���ڿ�, 14, '*')
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '******'
FROM EMPLOYEE;


-----------------------------------------------------------------------------------------------------
/*
    * LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM / RTRIM(STRING, ['�����ҹ��ڵ�'] => �����ϸ� ���� ����
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ���� �� ���ڿ� ��ȯ
*/

SELECT LTRIM('         K H ') FROM DUAL;  -- ���� ã�Ƽ� �����ϰ� ���� �ƴ� ���ڳ����� �׳� ����
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- ������ ���ڵ� �� �ϳ��� ���ص� ���ŵ�

SELECT RTRIM('5782KH123', '0123456789') FROM DUAL;

/*
    * TRIM
    ���ڿ��� �� / �� / ���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    
    TRIM([[LEADING, TRAILING, BOTH(�⺻��)] �����ϰ����ϴ� ���ڵ� FROM], STRING)
    
*/
-- �⺻�����δ� ���ʿ� �ִ� ���ڵ��� �� ã�Ƽ� ����
SELECT TRIM('          K  H   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZZZKHZZZZ') FROM DUAL;
--SELECT TRIM('ZZZZKHZZZZ', 'Z') FROM DUAL; ���� �ٲ�� �ȵ�

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING : �� => LTRIM �� ����
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING : �� => RTRIM �� ����
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- BOTH : ���� => ������ �⺻��

---------------------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    LOWER / UPPER / INITCAP (STRING) => ������� CHARACTER Ÿ��
    
    LOWER : �� �ҹ��ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� toLowCase() �޼ҵ�� ����)
    UPPER : �� �빮�ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� toUpperCase() �޼ҵ�� ����)
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('Welcome To My World!') FROM DUAL;

------------------------------------------------------------------------------------------

/*
    * CONCAT
    ���ڿ� �ΰ� ���޹޾� �ϳ��� ��ģ �� ��� ��ȯ
    
    CONCAT(STRING, STRING)    => ������� CHARACTER Ÿ������ ��ȯ
*/

SELECT CONCAT('ABC', '���ݸ�') FROM DUAL;
SELECT 'ABC' || '���ݸ�' FROM DUAL;

SELECT CONCAT('ABC', '���ݸ�', '123') FROM DUAL; -- ���� �߻� : CONCAT�� ���ڿ� 2���� ���� �� ����
SELECT 'ABC' || '���ݸ�' || '123' FROM DUAL;

----------------------------------------------------------------------------------------------













