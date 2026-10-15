-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labgmr_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labgmr; Owner: -
--

ALTER TABLE ONLY labgmr.labgmr_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
