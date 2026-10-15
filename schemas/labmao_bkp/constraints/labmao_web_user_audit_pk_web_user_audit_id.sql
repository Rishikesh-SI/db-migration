-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labmao_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labmao_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labmao_bkp; Owner: -
--

ALTER TABLE ONLY labmao_bkp.labmao_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
