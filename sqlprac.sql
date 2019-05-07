-- Select 기본
SELECT 
    *
FROM
    employees;
SELECT 
    *
FROM
    departments;
SELECT 
    first_name, gender, hire_date
FROM
    employees;
SELECT 
    CONCAT(first_name, ' ', last_name),
    gender AS '성별',
    hire_date AS '고용일'
FROM
    employees
ORDER BY hire_date DESC;
SELECT DISTINCT
    title
FROM
    titles;

SELECT 
    emp_no, salary, from_date
FROM
    salaries
WHERE
    from_date LIKE '2001%'
ORDER BY salary ASC;

SELECT 
    emp_no, salary, from_date
FROM
    salaries
WHERE
    from_date <= '1988.12.13';
-- 문자형 함수
SELECT UPPER('Seoul'), UCASE('seoul');
SELECT SUBSTRING('Happy day', 3, 2);
SELECT 
    UPPER(first_name)
FROM
    employees;
SELECT LPAD('hi', 5, '?');
SELECT LPAD('123456', 10, '@'), RPAD('123456', 10, '@');

SELECT 
    emp_no, LPAD(salary, 10, '*')
FROM
    salaries
WHERE
    from_date LIKE '2001-%'
        AND salary < 70000;

SELECT 
    CONCAT('-', LTRIM('     Hello    '), '--'),
    CONCAT('-', RTRIM('     Hello    '), '--'),
    CONCAT('-', TRIM('     Hello    '), '--'),
    CONCAT('-',
            TRIM(BOTH 'x' FROM 'xxxxxxHelloxxxxxx'),
            '--');

SELECT ABS(1), ABS(- 1);
SELECT MOD(234, 10), 234 % 10;
SELECT FLOOR(1.2345), FLOOR(- 1.2345);
SELECT CEILING(1.2345), CEILING(- 1.2345);
SELECT ROUND(1.2345), ROUND(- 1.2345);
SELECT POW(2, 3), POWER(2, - 3);
SELECT SIGN(- 10), SIGN(10), SIGN(0);
SELECT GREATEST(98, 60, 30), GREATEST('B', 'A', 'CA', 'CB');
SELECT LEAST(98, 60, 30), LEAST('B', 'A', 'CA', 'CB');

-- 날짜형 함수
SELECT CURDATE(), CURRENT_DATE;
SELECT CURTIME(), CURRENT_TIME;
SELECT NOW(), SYSDATE(), CURRENT_TIMESTAMP();

SELECT NOW(), SLEEP(2), NOW();
SELECT SYSDATE(), SLEEP(2), SYSDATE();
-- 현재시간을 참조하게 될 경우가 생기면 now()를 쓰자
-- sysdate는 쿼리가 진행되면서 계속 변하기떄문
SELECT 
    DATE_FORMAT(NOW(),
            '%Y년 %c월 %d일 %h시 %i분 %s초');
SELECT DATE_FORMAT(NOW(), '%Y-%c-%d %h:%i:%s');

SELECT 
    CONCAT(first_name, ' ', last_name) AS name,
    PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'),
            DATE_FORMAT(hire_date, '%Y%m'))
FROM
    employees;
  
SELECT 
    first_name, hire_date, DATE_ADD(hire_date, INTERVAL 5 MONTH)
FROM
    employees;
  
SELECT CAST(NOW() AS DATE);
SELECT CAST(1 - 2 AS UNSIGNED);
SELECT CAST(CAST(1 - 2 AS UNSIGNED) AS SIGNED);
  
  -- 집계(통계) 함수
SELECT 
    AVG(salary), SUM(salary)
FROM
    salaries
WHERE
    emp_no = '10060';
  
SELECT 
    emp_no, AVG(salary), SUM(salary)
FROM
    salaries
GROUP BY emp_no;
-- 통계합수를 쓰는애들은 group by 애들로 하자가 원칙
SELECT 
    emp_no, AVG(salary), SUM(salary)
FROM
    salaries
WHERE
    from_date LIKE '1985%'
GROUP BY emp_no
HAVING AVG(salary) >= 120000;


-- 기본 SQL 문제 
-- 문제1. 사번이 10944인 사원의 이름은(전체 이름)
SELECT 
    CONCAT(first_name, ' ', last_name) AS Full_Name
FROM
    employees
WHERE
    emp_no = 10944;

-- 문제2. 전체직원의 다음 정보를 조회하세요. 가장 선임부터 출력이 되도록 하세요. 출력은 이름, 성별,  입사일 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해 보세요.
SELECT 
    CONCAT(first_name, ' ', last_name) AS '이름',
    gender AS '성별',
    hire_date AS '입사일'
FROM
    employees
ORDER BY hire_date ASC;

-- 문제3. 여직원과 남직원은 각 각 몇 명이나 있나요?
SELECT 
    (SELECT 
            COUNT(*)
        FROM
            employees
        WHERE
            gender = 'm') AS 'Man',
    (SELECT 
            COUNT(*)
        FROM
            employees
        WHERE
            gender = 'f') AS 'Girl';
-- 문제4. 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.) 
SELECT 
    COUNT(DISTINCT emp_no) AS '직원 수'
FROM
    salaries;

-- 문제5.부서는 총 몇 개가 있나요?
SELECT 
    COUNT(*) AS '부서 갯수'
FROM
    departments;

-- 문제6. 현재 부서 매니저는 몇 명이나 있나요?(역임 매너저는 제외)
-- 부서별 매니저 수
SELECT 
    dept_no AS '부서명', COUNT(emp_no) AS '매니저 수'
FROM
    dept_manager
GROUP BY dept_no;
-- 전체 매니저 수
SELECT 
    COUNT(DISTINCT emp_no) AS '매니저 수'
FROM
    dept_manager;


-- 문제7. 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.
SELECT 
    dept_name AS '부서명', LENGTH(dept_name) AS '글자 수'
FROM
    departments
ORDER BY LENGTH(dept_name) DESC;

-- 문제8. 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?
SELECT 
    COUNT(emp_no) AS '120,000이상'
FROM
    salaries
WHERE
    salary >= 120000
        AND to_date LIKE '9999%';

-- 문제9. 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.
SELECT 
    title
FROM
    titles
GROUP BY title
ORDER BY LENGTH(title) DESC;

-- 문제10. 현재 Enginner 직책의 사원은 총 몇 명입니까?
SELECT 
    COUNT(*) AS 'Enginner수'
FROM
    titles
WHERE
    title = 'Engineer'
GROUP BY title;

-- 문제11. 사번이 13250(Zeydy)인 지원이 직책 변경 상황을 시간순으로 출력해보세요.
SELECT 
    emp_no AS 'Zeydy', title AS '직책'
FROM
    titles
WHERE
    emp_no = 13250
ORDER BY to_date ASC;


-------------------------------- 190507
select * from salaries where emp_no =11007;
-- 예제 1: 각 사원별로 평균 연봉 출력 
SELECT 
    emp_no, AVG(salary), MAX(salary)
FROM
    salaries
GROUP BY emp_no
ORDER BY AVG(salary) DESC;

-- 예제 2: 각 현재 Manager 직책 사원에 대한  평균 연봉은?
SELECT 
    emp_no, title
FROM
    titles
WHERE
    title = 'Manager';

-- 예제 3:  사원별 몇 번의 직책 변경이 있었는지 조회 
SELECT 
    emp_no, COUNT(title)
FROM
    titles
GROUP BY emp_no;

-- 예제4 : 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 50000;

-- 예제5: (현재) 직책별로 (평균 연봉)과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.
SELECT 
    title, COUNT(emp_no)
FROM
    titles
WHERE
    to_date = '9999-01-01'
GROUP BY title
HAVING COUNT(emp_no) >= 100;

-- 예제6: 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
SELECT 
    emp_no, salary
FROM
    salaries
WHERE
    to_date = '9999-01-01';
SELECT 
    emp_no, title
FROM
    titles
WHERE
    to_date = '9999-01-01';

SELECT 
    c.dept_no, d.dept_name, AVG(a.salary)
FROM
    salaries a,
    titles b,
    dept_emp c,
    departments d
WHERE
    a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
        AND a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND b.title = 'Engineer'
        AND c.dept_no = d.dept_no
GROUP BY c.dept_no;

-- 예제7: 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요
--         단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에
--         대해서 내림차순(DESC)로 정렬하세요.

SELECT 
    title, SUM(salary)
FROM
    titles a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY title
HAVING SUM(salary) >= 2000000000
ORDER BY SUM(salary) DESC;



-- 예제 8: employees 테이블과 titles 테이블를 join하여 직원의 이름과 직책을 모두 출력 하세요.
        
SELECT 
    a.first_name, b.title, a.gender
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no AND a.gender = 'F';
    
-- 예제9: 예제 8번에서 각 컬럼과 테이블에 ALIAS 를 지정하여 사원의 이름과 직책을 출력하세요. 

SELECT 
    a.first_name, b.title, a.gender
FROM
    employees a
        JOIN
    titles b ON a.emp_no = b.emp_no
WHERE
    a.gender = 'f';
    
--  Natural Join
SELECT 
    a.first_name, b.title, a.gender 
FROM
    employees a
        JOIN
    titles b
WHERE
    a.gender = 'f';

-- join~ using
SELECT 
    a.first_name, b.title, a.gender
FROM
    employees a
        JOIN
    titles b USING (emp_no)
WHERE
    a.gender = 'f';
    
    
-- 예제10: employees 테이블과 titles 테이블를 join하여 직원의 이름과 직책을 출력하되 여성 엔지니어만 출력하세요. 



-- 실습문제 1:  현재 회사 상황을 반영한 직원별 근무부서를 사번, 직원 전체이름, 직원별 근무부서 형태로 출력해 보세요.

SELECT 
    -- concat(a.first_name,' ',a.last_name),a.emp_no, c.dept_name
    a.first_name, b.dept_no,c.dept_name
FROM
    employees a
    left join dept_emp b on a.emp_no = b.emp_no
    join departments c on b.dept_no=c.dept_no
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no        
        and b.to_date = '9999-01-01'
        and b.dept_no is null;

