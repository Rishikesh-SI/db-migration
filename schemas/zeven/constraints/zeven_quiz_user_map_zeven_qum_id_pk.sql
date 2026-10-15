-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_quiz_user_map zeven_qum_id_pk
-- Type: CONSTRAINT

-- Name: zeven_quiz_user_map zeven_qum_id_pk; Type: CONSTRAINT; Schema: zeven; Owner: -
--

ALTER TABLE ONLY zeven.zeven_quiz_user_map
    ADD CONSTRAINT zeven_qum_id_pk PRIMARY KEY (qum_id);


--
