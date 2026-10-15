-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_user_poll_response isl_user_poll_response_id_pk
-- Type: CONSTRAINT

-- Name: labpc_user_poll_response isl_user_poll_response_id_pk; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_user_poll_response
    ADD CONSTRAINT isl_user_poll_response_id_pk PRIMARY KEY (user_poll_response_id);


--
