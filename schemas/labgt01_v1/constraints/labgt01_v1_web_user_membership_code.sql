-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_web_user membership_code
-- Type: CONSTRAINT

-- Name: labgt01_v1_web_user membership_code; Type: CONSTRAINT; Schema: labgt01_v1; Owner: -
--

ALTER TABLE ONLY labgt01_v1.labgt01_v1_web_user
    ADD CONSTRAINT membership_code UNIQUE (membership_code);


--
