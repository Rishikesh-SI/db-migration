-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_poll_option labtkr_poll_option_id
-- Type: CONSTRAINT

-- Name: labtkr_poll_option labtkr_poll_option_id; Type: CONSTRAINT; Schema: labtkr_beta; Owner: -
--

ALTER TABLE ONLY labtkr_beta.labtkr_poll_option
    ADD CONSTRAINT labtkr_poll_option_id PRIMARY KEY (poll_option_id);


--
