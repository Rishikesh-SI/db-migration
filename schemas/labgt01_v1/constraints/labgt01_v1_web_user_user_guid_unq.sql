-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_web_user user_guid_unq
-- Type: CONSTRAINT

-- Name: labgt01_v1_web_user user_guid_unq; Type: CONSTRAINT; Schema: labgt01_v1; Owner: -
--

ALTER TABLE ONLY labgt01_v1.labgt01_v1_web_user
    ADD CONSTRAINT user_guid_unq UNIQUE (user_guid);


--
