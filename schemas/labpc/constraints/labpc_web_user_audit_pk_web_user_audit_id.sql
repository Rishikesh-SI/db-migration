-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labpc_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
