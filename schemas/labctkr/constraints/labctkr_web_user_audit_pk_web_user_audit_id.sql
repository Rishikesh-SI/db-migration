-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: labctkr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labctkr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labctkr; Owner: -
--

ALTER TABLE ONLY labctkr.labctkr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
