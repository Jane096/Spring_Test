## Spring기반 웹 게시판 

### 프로젝트 개요
 신입 개발자의 기본 소양이며 웹 구현에 필수 요소인 게시판의 기능을 숙지함과 동시에 Spring framework의 학습을 위해 제작 중인 게시판 CRUD 웹사이트 1인 프로젝트 입니다

### 프로젝트 기간
* 06/02 기준 12일 소요

### 프로젝트 일정
- 2020/05/13 ~ 2020/05/14 : Spring 환경설정 및 Oracle DB, Github-eclipse연동
- 2020/05/15 ~ 2020/05/18 : Spring MVC패턴의 개념 정리
- 2020/05/19 ~ 2020/05/19 : 게시판 CRUD Model, Controller 설계
- 2020/05/20 ~ 2020/05/21 : 게시판 View부분을 Bootstrap을 이용하여 설계
- 2020/05/22 ~ 2020/05/24 : 게시판 댓글 기능(front, back) REST 방식을 통해 구현
- 2020/05/26 ~ 2020/05/27 : 첨부파일 기능 추가 완료(Transactional, scheduler 사용) 
- 2020/05/28 ~ 2020/05/29 : Spring web security를 이용한 로그인, 게시물 인증 권한 기능 구현
- 2020/06/02 ~ 2020/06/02 : 댓글, 첨부파일에 spring security 적용/ 로그인,로그아웃 기능 완성 
- 2020/06/03 ~  :  회원가입 기능 구현 예정

### 프로젝트 활용기술
- Front-End : HTML5, CSS3, Javascript, jQuery, Ajax,Bootstrap 4
- Back-End : Spring(STS), Java 8, Oracle Database 11g, Mybatis, Apache Tomcat 9, JSP, REST API
- IDE : Eclipse IDE, SQL Developer
- Others: Git, Github, SourceTree


### 화면 구성도
- [pdf 이미지 파일](SpringProjectImage.pdf)로 간략하게 설명되어있으니 참고 부탁드립니다!

### 개선사항
- 삭제 처리 기능에 인증 권한 부여 
- 데이터베이스를 이용하여 자동 로그인(remember-me) 기능 추가
- 댓글, 첨부파일에 인증 권한 부여 
