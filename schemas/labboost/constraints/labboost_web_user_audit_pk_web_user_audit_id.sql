-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labboost_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
