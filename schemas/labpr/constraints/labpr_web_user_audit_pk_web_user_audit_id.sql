-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labpr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
