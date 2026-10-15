-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labukk_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labukk; Owner: -
--

ALTER TABLE ONLY labukk.labukk_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
