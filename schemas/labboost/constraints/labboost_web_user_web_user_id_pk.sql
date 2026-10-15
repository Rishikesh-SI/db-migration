-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labboost_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
