-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_user_info user_info_id_pk
-- Type: CONSTRAINT

-- Name: stn_user_info user_info_id_pk; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_user_info
    ADD CONSTRAINT user_info_id_pk PRIMARY KEY (user_id);


--
