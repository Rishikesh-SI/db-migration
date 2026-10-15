-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: lablakr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: lablakr; Owner: -
--

ALTER TABLE ONLY lablakr.lablakr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
