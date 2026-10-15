-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_user_poll_response isl_user_poll_response_id_pk
-- Type: CONSTRAINT

-- Name: labdv_user_poll_response isl_user_poll_response_id_pk; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_user_poll_response
    ADD CONSTRAINT isl_user_poll_response_id_pk PRIMARY KEY (user_poll_response_id);


--
