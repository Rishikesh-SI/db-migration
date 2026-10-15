-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_user_poll_response isl_user_poll_response_id_pk
-- Type: CONSTRAINT

-- Name: labrstg_user_poll_response isl_user_poll_response_id_pk; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_user_poll_response
    ADD CONSTRAINT isl_user_poll_response_id_pk PRIMARY KEY (user_poll_response_id);


--
