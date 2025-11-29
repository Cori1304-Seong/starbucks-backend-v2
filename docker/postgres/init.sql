-- PostgreSQL 초기화 스크립트
-- POSTGRES_USER 환경 변수로 이미 study_index_user가 생성되므로
-- 추가 설정만 수행

-- 스키마 권한 부여 (PostgreSQL 15+에서 필요)
GRANT ALL ON SCHEMA public TO study_index_user;

-- 향후 생성될 테이블에 대한 권한 부여
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO study_index_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO study_index_user;
