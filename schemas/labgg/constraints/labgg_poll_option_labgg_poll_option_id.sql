-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_poll_option labgg_poll_option_id
-- Type: CONSTRAINT

-- Name: labgg_poll_option labgg_poll_option_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_poll_option
    ADD CONSTRAINT labgg_poll_option_id PRIMARY KEY (poll_option_id);


--
