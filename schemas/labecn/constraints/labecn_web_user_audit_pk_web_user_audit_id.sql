-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labecn_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labecn; Owner: -
--

ALTER TABLE ONLY labecn.labecn_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
