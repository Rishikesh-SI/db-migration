-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labrg_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labrg; Owner: -
--

ALTER TABLE ONLY labrg.labrg_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
