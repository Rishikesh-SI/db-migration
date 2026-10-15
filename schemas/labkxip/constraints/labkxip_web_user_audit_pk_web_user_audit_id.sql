-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labkxip_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labkxip; Owner: -
--

ALTER TABLE ONLY labkxip.labkxip_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
