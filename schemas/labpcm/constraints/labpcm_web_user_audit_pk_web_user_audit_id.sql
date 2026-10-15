-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labpcm_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
