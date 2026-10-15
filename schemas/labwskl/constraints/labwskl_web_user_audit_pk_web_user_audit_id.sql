-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labwskl_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labwskl; Owner: -
--

ALTER TABLE ONLY labwskl.labwskl_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
