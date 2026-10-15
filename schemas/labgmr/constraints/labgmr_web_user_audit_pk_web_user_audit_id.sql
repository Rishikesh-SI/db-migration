-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labgmr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labgmr; Owner: -
--

ALTER TABLE ONLY labgmr.labgmr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
