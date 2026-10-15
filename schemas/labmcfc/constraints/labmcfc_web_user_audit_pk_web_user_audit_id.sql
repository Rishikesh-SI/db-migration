-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labmcfc_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labmcfc; Owner: -
--

ALTER TABLE ONLY labmcfc.labmcfc_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
