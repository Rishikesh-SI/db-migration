-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: cli_stp_v1_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: cli_stp_v1; Owner: -
--

ALTER TABLE ONLY cli_stp_v1.cli_stp_v1_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
