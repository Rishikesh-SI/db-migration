-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labrr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labrr_beta_08042024; Owner: -
--

ALTER TABLE ONLY labrr_beta_08042024.labrr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
