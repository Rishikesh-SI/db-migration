-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_poll_option labrlp_poll_option_id
-- Type: CONSTRAINT

-- Name: labrlp_poll_option labrlp_poll_option_id; Type: CONSTRAINT; Schema: labrlp; Owner: -
--

ALTER TABLE ONLY labrlp.labrlp_poll_option
    ADD CONSTRAINT labrlp_poll_option_id PRIMARY KEY (poll_option_id);


--
