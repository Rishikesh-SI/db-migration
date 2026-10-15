-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_web_user_audit pk_web_user_audit_id
-- Type: CONSTRAINT

-- Name: labal_nassr_web_user_audit pk_web_user_audit_id; Type: CONSTRAINT; Schema: labal_nassr; Owner: -
--

ALTER TABLE ONLY labal_nassr.labal_nassr_web_user_audit
    ADD CONSTRAINT pk_web_user_audit_id PRIMARY KEY (audit_id);


--
