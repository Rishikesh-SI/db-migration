-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labw88_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labw88; Owner: -
--

ALTER TABLE ONLY labw88.labw88_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
