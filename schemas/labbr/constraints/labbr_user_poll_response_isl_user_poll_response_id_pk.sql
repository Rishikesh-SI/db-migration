-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_user_poll_response isl_user_poll_response_id_pk
-- Type: CONSTRAINT

-- Name: labbr_user_poll_response isl_user_poll_response_id_pk; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_user_poll_response
    ADD CONSTRAINT isl_user_poll_response_id_pk PRIMARY KEY (user_poll_response_id);


--
