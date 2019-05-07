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

-- 집계(통계) SQL 문제입니다.

-- 문제 1. 
-- 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 두 임금의 차이는 얼마인가요? 함께 “최고임금 – 최저임금”이란 타이틀로 출력해 보세요.
SELECT 
    MIN(salary) AS '최저임금',
    MAX(salary) AS '최고임금',
    MAX(salary) - MIN(salary) AS '최고임금 - 최저임금'
FROM
    salaries;

-- 문제2.
-- 마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일
SELECT 
   DATE_FORMAT(min(from_date), '%Y년 %c월 %d일') AS '마지막 신입사원 입사'   
FROM
    salaries
    group by emp_no
    order by min(from_date) desc
    limit 0,1;

-- 문제3.
-- 가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일

SELECT 
    DATE_FORMAT((from_date), '%Y년 %c월 %d일') AS '가장 오래 근속한 직원의 입사일'
FROM
    salaries
GROUP BY emp_no
ORDER BY MAX(to_date) - MIN(from_date) DESC
LIMIT 0 , 1;

-- 문제4.
-- 현재 이 회사의 평균 연봉은 얼마입니까?
SELECT 
    AVG(salary) AS '평균 연봉'
FROM
    salaries
WHERE
    to_date = '9999-01-01';

-- 문제5.
-- 현재 이 회사의 최고/최저 연봉은 얼마입니까?

SELECT 
    MIN(salary) AS '최저연봉', MAX(salary) AS '최고연봉'
FROM
    salaries
WHERE
    to_date = '9999-01-01';

-- 문제6.
-- 최고 어린 사원의 나이와 최 연장자의 나이는?
-- 연도만 출력
SELECT 
    MIN(birth_date) AS '최 연장자',
    MAX(birth_date) AS '가장 어린 사원'
FROM
    employees;

-- 나이 출력
SELECT 
    DATE_FORMAT(NOW(), '%Y-%m-%d') - DATE_FORMAT(MIN(birth_date), '%Y-%m-%d') + 1 AS '최연장자',
    DATE_FORMAT(NOW(), '%Y-%m-%d') - DATE_FORMAT(MAX(birth_date), '%Y-%m-%d') + 1 AS '가장 어린 사원'
FROM
    employees;


-- 테이블간 조인(JOIN) SQL 문제입니다.
-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
SELECT 
    a.emp_no AS '사번',
    CONCAT(b.first_name, ' ', b.last_name) AS '이름',
    a.salary AS '연봉'
FROM
    salaries a,
    employees b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
ORDER BY a.salary DESC;

-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    b.title '현재 직책'
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
ORDER BY a.first_name ASC;

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    c.dept_name '현재부서'
FROM
    employees a,
    dept_emp b,
    departments c
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND b.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name) ASC;

-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    b.salary '연봉',
    d.title '직책',
    e.dept_name '부서명'
FROM
    employees a,
    salaries b,
    dept_emp c,
    titles d,
    departments e
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND c.emp_no = d.emp_no
        AND c.dept_no = e.dept_no
        AND b.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name) ASC;
-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름'
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND b.title = 'Technique Leader'
        AND NOT b.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name) ASC;

-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    d.dept_name '부서명',
    b.title '직책'
FROM
    employees a,
    titles b,
    dept_emp c,
    departments d
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND c.dept_no = d.dept_no
        AND b.to_date = '9999-01-01'
        AND a.last_name LIKE 'S%'
ORDER BY CONCAT(a.first_name, ' ', a.last_name) ASC;
        
-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
SELECT 
    b.emp_no '사번', a.title '직책', c.salary '급여'
FROM
    titles a,
    employees b,
    salaries c
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND a.title = 'Engineer'
        AND a.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND c.salary >= 40000
ORDER BY c.salary DESC;

-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
SELECT 
    b.title '직책', a.salary '급여'
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
        AND a.salary >= 50000
ORDER BY a.salary DESC;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
SELECT 
    c.dept_name '부서명',
    b.dept_no '부서번호',
    AVG(salary) '부서별 평균 연봉'
FROM
    salaries a,
    dept_emp b,
    departments c
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.dept_no
ORDER BY AVG(salary) DESC;

-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
SELECT 
    b.title '직책', AVG(a.salary) '연봉'
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY AVG(a.salary) DESC;