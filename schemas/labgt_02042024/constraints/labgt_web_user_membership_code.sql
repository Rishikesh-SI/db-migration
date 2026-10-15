-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_web_user membership_code
-- Type: CONSTRAINT

-- Name: labgt_web_user membership_code; Type: CONSTRAINT; Schema: labgt_02042024; Owner: -
--

ALTER TABLE ONLY labgt_02042024.labgt_web_user
    ADD CONSTRAINT membership_code UNIQUE (membership_code);


--
