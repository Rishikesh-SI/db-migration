-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labos_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
