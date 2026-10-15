-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: labwafdemo_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labwafdemo_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labwafdemo; Owner: -
--

ALTER TABLE ONLY labwafdemo.labwafdemo_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
