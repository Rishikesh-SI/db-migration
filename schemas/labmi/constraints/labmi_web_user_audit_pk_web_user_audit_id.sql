-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labmi_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
