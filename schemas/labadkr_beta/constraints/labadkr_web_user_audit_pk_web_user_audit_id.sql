-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labadkr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labadkr_beta; Owner: -
--

ALTER TABLE ONLY labadkr_beta.labadkr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
