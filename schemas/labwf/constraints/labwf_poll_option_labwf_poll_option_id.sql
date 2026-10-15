-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_poll_option labwf_poll_option_id
-- Type: CONSTRAINT

-- Name: labwf_poll_option labwf_poll_option_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_poll_option
    ADD CONSTRAINT labwf_poll_option_id PRIMARY KEY (poll_option_id);


--
