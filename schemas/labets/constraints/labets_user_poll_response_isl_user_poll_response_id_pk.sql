-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_user_poll_response isl_user_poll_response_id_pk
-- Type: CONSTRAINT

-- Name: labets_user_poll_response isl_user_poll_response_id_pk; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_user_poll_response
    ADD CONSTRAINT isl_user_poll_response_id_pk PRIMARY KEY (user_poll_response_id);


--
