-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labgfg_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labgfg; Owner: -
--

ALTER TABLE ONLY labgfg.labgfg_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
