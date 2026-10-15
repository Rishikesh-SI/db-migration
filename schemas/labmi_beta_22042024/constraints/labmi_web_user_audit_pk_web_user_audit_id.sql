-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labmi_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labmi_beta_22042024; Owner: -
--

ALTER TABLE ONLY labmi_beta_22042024.labmi_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
