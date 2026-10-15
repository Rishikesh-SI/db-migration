-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labhkind_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
