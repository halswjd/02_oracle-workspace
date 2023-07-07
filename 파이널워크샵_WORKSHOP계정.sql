
-- 1. 4�� ���̺� ���Ե� ������ �� ���� ���ϴ� SQL ������ ����� SQL ������ �ۼ��Ͻÿ�.
SELECT COUNT(*) FROM TB_BOOK;
SELECT COUNT(*) FROM TB_BOOK_AUTHOR;
SELECT COUNT(*) FROM TB_PUBLISHER;
SELECT COUNT(*) FROM TB_WRITER;

-- 3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.

SELECT * FROM TB_BOOK;

SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

-- 4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
--    �̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_WRITER;

SELECT WRITER_NM,OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM TB_WRITER
WHERE MOBILE_NO LIKE '019%' AND WRITER_NM LIKE '��%'
ORDER BY 1;

SELECT WRITER_NM,OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM (SELECT WRITER_NM,OFFICE_TELNO, HOME_TELNO, MOBILE_NO
        FROM TB_WRITER
        WHERE MOBILE_NO LIKE '019%' AND WRITER_NM LIKE '��%'
        ORDER BY 1)
WHERE ROWNUM = 1;

-- 5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ���۰�(��)������ ǥ�õǵ��� �� ��)

SELECT * FROM TB_BOOK_AUTHOR;

SELECT COMPOSE_TYPE, COUNT(DISTINCT WRITER_NO) AS "�۰�(��)"
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE = '�ű�'
GROUP BY COMPOSE_TYPE;

-- 6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.(�������°� ��ϵ��� ���� ���� ������ ��)
-- ���� ���� ����
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_BOOK;

SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300;

-- 7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_BOOK;

SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM TB_BOOK
ORDER BY 2 DESC;

SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM (SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
        FROM TB_BOOK
    ORDER BY 2 DESC)
WHERE ROWNUM = 1;

--8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �Ұ�)
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK;
SELECT * FROM TB_BOOK_AUTHOR;

SELECT WRITER_NM, COUNT(*)
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
GROUP BY WRITER_NM
ORDER BY 2 DESC;

SELECT WRITER_NM AS "�۰��̸�", "�� ��"
FROM (SELECT WRITER_NM, COUNT(*) AS "�� ��"
        FROM TB_BOOK_AUTHOR
        JOIN TB_WRITER USING (WRITER_NO)
    GROUP BY WRITER_NM
    ORDER BY 2 DESC)
WHERE ROWNUM <= 3;

--9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰���
--  ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)
SELECT * FROM TB_WRITER; -- WRITER_NO
SELECT * FROM TB_BOOK_AUTHOR; -- BOOK_NO, WRITER_NO
SELECT * FROM TB_BOOK; -- BOOK_NO

SELECT WRITER_NM, MIN(ISSUE_DATE)
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO)
GROUP BY WRITER_NM
ORDER BY 1;

UPDATE TB_WRITER W
SET REGIST_DATE = (SELECT MIN(ISSUE_DATE)
                    FROM TB_BOOK  
                    JOIN TB_BOOK_AUTHOR B USING (BOOK_NO)
                    WHERE W.WRITER_NO = B.WRITER_NO);
--GROUP BY WRITER_NM);

ROLLBACK;
-- 10. 
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK,
    WRITER_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER,
    TRANS_LANG VARCHAR(60),
    CONSTRAINT PK_BOOK_TRASLATOR PRIMARY KEY(BOOK_NO,WRITER_NO)
);

COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO IS '�۰���ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG IS '�������';


-- 11.
SELECT * FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

INSERT INTO TB_BOOK_TRANSLATOR(BOOK_NO,WRITER_NO) (
    SELECT BOOK_NO, WRITER_NO
    FROM TB_BOOK_AUTHOR
    WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����')
);

DELETE FROM TB_BOOK_AUTHOR
WHERE (BOOK_NO,WRITER_NO) IN (SELECT BOOK_NO, WRITER_NO
                               FROM TB_BOOK_AUTHOR
                              WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����'));

ROLLBACK;

-- 12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT BOOK_NM, WRITER_NM
FROM TB_BOOK_TRANSLATOR
JOIN TB_BOOK USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO)
WHERE BOOK_NO LIKE '2007%';

--13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL
--������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, ��������
--ǥ�õǵ��� �� ��)
CREATE OR REPLACE VIEW VW_BOOK_TRANSLATOR
AS SELECT BOOK_NM, WRITER_NM, ISSUE_DATE
    FROM TB_BOOK_TRANSLATOR
    JOIN TB_BOOK USING (BOOK_NO)
    JOIN TB_WRITER USING (WRITER_NO)
    WHERE BOOK_NO LIKE '2007%'
WITH READ ONLY;
 
-- ...?   
    
GRANT CREATE VIEW TO WORKSHOP;

-- 14.
SELECT * FROM TB_PUBLISHER;

INSERT INTO TB_PUBLISHER VALUES('�� ���ǻ�', '02-6710-3737', DEFAULT);

-- 15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_WRITER WHERE WRITER_NM LIKE '��%'ORDER BY WRITER_NM;

SELECT WRITER_NM, COUNT(*)
FROM TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(*) >= 2;

-- 16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�.
-- �ش� �÷��� NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
SELECT * FROM TB_BOOK_AUTHOR WHERE COMPOSE_TYPE IS NULL;

UPDATE TB_BOOK_AUTHOR
SET COMPOSE_TYPE = '����'
WHERE COMPOSE_TYPE IS NULL;

-- 17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�,
-- �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰��� �̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�
SELECT WRITER_NM, OFFICE_TELNO
FROM TB_WRITER
WHERE OFFICE_TELNO LIKE '02%' AND OFFICE_TELNO LIKE '__-___-%';

-- 18.2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT WRITER_NM
FROM TB_WRITER
WHERE FLOOR(MONTHS_BETWEEN('06/01/01',REGIST_DATE)) >= 372
ORDER BY 1;

-- 19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���' 
-- ���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�. ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
-- �������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�

SELECT BOOK_NM, PRICE, 
       CASE WHEN STOCK_QTY < 5 THEN '�߰��ֹ��ʿ�'
       ELSE '�ҷ�����'
       END AS "������"
FROM TB_BOOK
WHERE PUBLISHER_NM = 'Ȳ�ݰ���' AND STOCK_QTY < 10
ORDER BY 3;

-- 20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������,�����ڡ�,�����ڡ��� ǥ���� ��)
SELECT * FROM TB_BOOK;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_TRANSLATOR;
SELECT * FROM TB_BOOK_AUTHOR;


SELECT B.BOOK_NO AS "������" , W.WRITER_NM AS "����", W2.WRITER_NM AS "����"
FROM TB_BOOK B
JOIN TB_BOOK_AUTHOR A ON (B.BOOK_NO = A.BOOK_NO)
JOIN TB_WRITER W ON (A.WRITER_NO = W.WRITER_NO)
JOIN TB_BOOK_TRANSLATOR T ON(B.BOOK_NO = T.BOOK_NO)
JOIN TB_WRITER W2 ON (T.WRITER_NO = W2.WRITER_NO)
WHERE B.BOOK_NM = '��ŸƮ��';


-- 21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ���
-- ����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������, �����
-- ������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ����������� ǥ�õǵ��� �� ��)
SELECT * FROM TB_BOOK;

SELECT BOOK_NM AS "������", STOCK_QTY AS "����", TO_CHAR(PRICE,'99,999') AS "����(Org)", TO_CHAR(PRICE*0.8,'99,999') AS "����(New)"
FROM TB_BOOK
WHERE FLOOR(SYSDATE - ISSUE_DATE)/365 >= 30 AND STOCK_QTY >= 90
ORDER BY 2 DESC, 4 DESC, BOOK_NM;





