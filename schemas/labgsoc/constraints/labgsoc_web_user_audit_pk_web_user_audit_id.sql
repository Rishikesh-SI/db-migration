-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labgsoc_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
