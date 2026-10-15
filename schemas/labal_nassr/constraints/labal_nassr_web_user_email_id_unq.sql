-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labal_nassr_web_user email_id_unq; Type: CONSTRAINT; Schema: labal_nassr; Owner: -
--

ALTER TABLE ONLY labal_nassr.labal_nassr_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
