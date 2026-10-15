-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: spz_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: spz; Owner: -
--

ALTER TABLE ONLY spz.spz_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
