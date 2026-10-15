-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_user_poll_response stlz_user_poll_response_id_pk
-- Type: CONSTRAINT

-- Name: labmcfc_user_poll_response stlz_user_poll_response_id_pk; Type: CONSTRAINT; Schema: labmcfc; Owner: -
--

ALTER TABLE ONLY labmcfc.labmcfc_user_poll_response
    ADD CONSTRAINT stlz_user_poll_response_id_pk PRIMARY KEY (user_poll_response_id);


--
