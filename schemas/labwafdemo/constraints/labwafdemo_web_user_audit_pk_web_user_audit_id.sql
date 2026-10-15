-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: labwafdemo_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labwafdemo_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labwafdemo; Owner: -
--

ALTER TABLE ONLY labwafdemo.labwafdemo_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
