
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

SELECT WRITER_NM, BOOK_NM, ISSUE_DATE
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO)
ORDER BY 1, 3;

SELECT WRITER_NM, MIN(ISSUE_DATE)
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO)
GROUP BY WRITER_NM
ORDER BY 1;

SELECT BOOK_NO, WRITER_NM, BOOK_NM, ISSUE_DATE
FROM (SELECT BOOK_NO, WRITER_NM, BOOK_NM, ISSUE_DATE
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO)
ORDER BY 1, 3)
;

UPDATE TB_WRITER
SET REGIST_DATE IN (SELECT MIN(ISSUE_DATE)
                    FROM TB_BOOK
                    JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
                    JOIN TB_WRITER USING (WRITER_NO)
                    GROUP BY WRITER_NM)
WHERE WRITER_NM IN (SELECT WRITER_NM
                    FROM TB_BOOK
                    JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
                    JOIN TB_WRITER USING (WRITER_NO)
                    GROUP BY WRITER_NM);















