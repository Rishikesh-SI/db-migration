-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_poll_response kxp_poll_response_id
-- Type: CONSTRAINT

-- Name: kxp_poll_response kxp_poll_response_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_poll_response
    ADD CONSTRAINT kxp_poll_response_id PRIMARY KEY (poll_response_id);


--
