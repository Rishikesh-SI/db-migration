-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labadkr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labadkr; Owner: -
--

ALTER TABLE ONLY labadkr.labadkr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
