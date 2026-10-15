-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labbsc_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
