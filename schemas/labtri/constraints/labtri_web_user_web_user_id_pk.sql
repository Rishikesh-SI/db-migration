-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labtri_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
