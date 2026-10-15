-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labpkl_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labpkl; Owner: -
--

ALTER TABLE ONLY labpkl.labpkl_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
