-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labrs_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labrs_2602; Owner: -
--

ALTER TABLE ONLY labrs_2602.labrs_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
