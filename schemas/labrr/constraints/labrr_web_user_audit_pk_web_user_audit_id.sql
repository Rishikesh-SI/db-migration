-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labrr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
