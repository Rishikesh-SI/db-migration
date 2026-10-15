-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labiis_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labiis; Owner: -
--

ALTER TABLE ONLY labiis.labiis_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
