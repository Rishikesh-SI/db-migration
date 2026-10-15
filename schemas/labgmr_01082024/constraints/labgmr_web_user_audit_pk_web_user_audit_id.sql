-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labgmr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labgmr_01082024; Owner: -
--

ALTER TABLE ONLY labgmr_01082024.labgmr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
