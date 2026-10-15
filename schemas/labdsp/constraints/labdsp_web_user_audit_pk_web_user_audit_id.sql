-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labdsp_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labdsp; Owner: -
--

ALTER TABLE ONLY labdsp.labdsp_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
