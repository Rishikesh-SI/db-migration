-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labmsg_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
