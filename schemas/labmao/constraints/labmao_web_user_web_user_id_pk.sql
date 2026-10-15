-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labmao_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labmao; Owner: -
--

ALTER TABLE ONLY labmao.labmao_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
