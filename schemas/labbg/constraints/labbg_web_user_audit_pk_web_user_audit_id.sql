-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labbg_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labbg; Owner: -
--

ALTER TABLE ONLY labbg.labbg_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
