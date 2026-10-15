-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labmao_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labmao; Owner: -
--

ALTER TABLE ONLY labmao.labmao_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
