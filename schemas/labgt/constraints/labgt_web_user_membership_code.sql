-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_web_user membership_code
-- Type: CONSTRAINT

-- Name: labgt_web_user membership_code; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_web_user
    ADD CONSTRAINT membership_code UNIQUE (membership_code);


--
