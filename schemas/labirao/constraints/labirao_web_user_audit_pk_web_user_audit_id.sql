-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labirao_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labirao; Owner: -
--

ALTER TABLE ONLY labirao.labirao_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
