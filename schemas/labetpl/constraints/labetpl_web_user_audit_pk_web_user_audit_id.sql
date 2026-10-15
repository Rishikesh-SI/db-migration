-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labetpl_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
