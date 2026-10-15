-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_web_user user_guid_unq
-- Type: CONSTRAINT

-- Name: labgt_web_user user_guid_unq; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_web_user
    ADD CONSTRAINT user_guid_unq UNIQUE (user_guid);


--
