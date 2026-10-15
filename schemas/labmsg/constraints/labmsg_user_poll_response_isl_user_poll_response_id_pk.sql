-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_user_poll_response isl_user_poll_response_id_pk
-- Type: CONSTRAINT

-- Name: labmsg_user_poll_response isl_user_poll_response_id_pk; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_user_poll_response
    ADD CONSTRAINT isl_user_poll_response_id_pk PRIMARY KEY (user_poll_response_id);


--
