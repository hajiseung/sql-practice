-- Select 기본
select * from employees;
select * from departments;
select first_name,gender,hire_date from employees;
select concat(first_name, ' ',last_name)
,gender as '성별',
hire_date as '고용일'
from employees
order by hire_date desc;
select distinct title from titles;

select emp_no,salary,from_date from salaries where from_date like '2001%' order by salary asc;

 select emp_no,salary,from_date from salaries where from_date<='1988.12.13';
-- 문자형 함수
select upper('Seoul'), ucase('seoul');
select substring('Happy day',3,2);
select upper(first_name) from employees;
select lpad('hi',5,'?');
select lpad('123456',10,'@'), rpad('123456',10,'@');

select emp_no,lpad(salary,10,'*')
from salaries
where from_date like'2001-%'
and salary<70000;

select concat('-',LTRIM('     Hello    '),'--'),
concat('-',RTRIM('     Hello    '),'--'),
concat('-',TRIM('     Hello    '),'--'),
concat('-',TRIM(both'x' from 'xxxxxxHelloxxxxxx'),'--');

select abs(1),abs(-1);
select mod(234,10),234%10;
select floor(1.2345),floor(-1.2345);
select ceiling(1.2345),ceiling(-1.2345);
select round(1.2345),round(-1.2345);
select pow(2,3),power(2,-3);
select sign(-10),sign(10),sign(0);
select greatest(98,60,30),greatest('B','A','CA','CB');
select least(98,60,30),least('B','A','CA','CB');

-- 날짜형 함수
select curdate(),current_date;
select curtime(),current_time;
select now(), sysdate(),current_timestamp();

select now(), sleep(2), now();
select sysdate(), sleep(2), sysdate();
-- 현재시간을 참조하게 될 경우가 생기면 now()를 쓰자
-- sysdate는 쿼리가 진행되면서 계속 변하기떄문
select date_format(now(),'%Y년 %c월 %d일 %h시 %i분 %s초');
select date_format(now(),'%Y-%c-%d %h:%i:%s');

SELECT concat(first_name, ' ', last_name) AS name,               
       PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m'),  
                    DATE_FORMAT(hire_date, '%Y%m') )
  FROM employees;
  
select first_name, hire_date,date_add(hire_date,interval 5 month)
  from employees;
  
select cast(now() as date);
select cast(1-2 as unsigned);
select cast(cast(1-2 as unsigned) as signed);
  
  -- 집계(통계) 함수
select avg(salary),sum(salary)
	from salaries
    where emp_no ='10060';
  
select emp_no,avg(salary),sum(salary)
	from salaries
   group by emp_no;
-- 통계합수를 쓰는애들은 group by 애들로 하자가 원칙
select emp_no,avg(salary),sum(salary)
	from salaries
    where from_date like '1985%' 
   group by emp_no having avg(salary)>=120000;


-- 기본 SQL 문제 
-- 문제1. 사번이 10944인 사원의 이름은(전체 이름)
select concat(first_name,' ',last_name) as Full_Name from employees where emp_no=10944;

-- 문제2. 전체직원의 다음 정보를 조회하세요. 가장 선임부터 출력이 되도록 하세요. 출력은 이름, 성별,  입사일 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해 보세요.
select concat(first_name,' ',last_name) as '이름',gender as '성별', hire_date as '입사일' from employees order by hire_date asc;

-- 문제3. 여직원과 남직원은 각 각 몇 명이나 있나요?
select (select count(*) from employees where gender='m') as 'Man',(select count(*) from employees where gender='f') as 'Girl';
-- 문제4. 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.) 
select count(distinct emp_no) as '직원 수' from salaries;

-- 문제5.부서는 총 몇 개가 있나요?
select count(*) as '부서 갯수' from departments;

-- 문제6. 현재 부서 매니저는 몇 명이나 있나요?(역임 매너저는 제외)
-- 부서별 매니저 수
select dept_no as '부서명',count(emp_no) as '매니저 수' from dept_manager group by dept_no;
-- 전체 매니저 수
select count(distinct emp_no) as '매니저 수' from dept_manager;


-- 문제7. 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.
select dept_name as '부서명',length(dept_name) as '글자 수' from departments order by length(dept_name) desc;

-- 문제8. 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?
select count(emp_no) as '120,000이상' from salaries where salary>=120000 and to_date like '9999%';

-- 문제9. 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.
select title from titles group by title order by length(title) desc;

-- 문제10. 현재 Enginner 직책의 사원은 총 몇 명입니까?
select count(*) as 'Enginner수' from titles where title='Engineer' group by title;

-- 문제11. 사번이 13250(Zeydy)인 지원이 직책 변경 상황을 시간순으로 출력해보세요.
select emp_no as 'Zeydy', title as '직책' from titles where emp_no=13250 order by to_date asc;