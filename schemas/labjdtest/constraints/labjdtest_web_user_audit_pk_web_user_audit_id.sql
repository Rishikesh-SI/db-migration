-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labjdtest_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labjdtest; Owner: -
--

ALTER TABLE ONLY labjdtest.labjdtest_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
