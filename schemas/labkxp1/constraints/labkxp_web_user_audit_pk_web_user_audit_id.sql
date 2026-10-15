-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labkxp_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labkxp1; Owner: -
--

ALTER TABLE ONLY labkxp1.labkxp_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
