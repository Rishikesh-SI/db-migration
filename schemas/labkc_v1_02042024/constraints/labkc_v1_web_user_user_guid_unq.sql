-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_web_user user_guid_unq
-- Type: CONSTRAINT

-- Name: labkc_v1_web_user user_guid_unq; Type: CONSTRAINT; Schema: labkc_v1_02042024; Owner: -
--

ALTER TABLE ONLY labkc_v1_02042024.labkc_v1_web_user
    ADD CONSTRAINT user_guid_unq UNIQUE (user_guid);


--
