-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labisp_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
