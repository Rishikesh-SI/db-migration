-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labkc_v1_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labkc_v1_02042024; Owner: -
--

ALTER TABLE ONLY labkc_v1_02042024.labkc_v1_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
