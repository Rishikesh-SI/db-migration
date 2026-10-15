-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labrlp_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labrlp; Owner: -
--

ALTER TABLE ONLY labrlp.labrlp_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
