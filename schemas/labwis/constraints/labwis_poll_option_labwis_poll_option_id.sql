-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_poll_option labwis_poll_option_id
-- Type: CONSTRAINT

-- Name: labwis_poll_option labwis_poll_option_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_poll_option
    ADD CONSTRAINT labwis_poll_option_id PRIMARY KEY (poll_option_id);


--
