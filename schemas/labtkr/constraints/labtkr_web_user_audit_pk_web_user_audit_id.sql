-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labtkr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labtkr; Owner: -
--

ALTER TABLE ONLY labtkr.labtkr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
