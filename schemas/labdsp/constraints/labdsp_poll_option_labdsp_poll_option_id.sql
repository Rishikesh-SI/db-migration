-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_poll_option labdsp_poll_option_id
-- Type: CONSTRAINT

-- Name: labdsp_poll_option labdsp_poll_option_id; Type: CONSTRAINT; Schema: labdsp; Owner: -
--

ALTER TABLE ONLY labdsp.labdsp_poll_option
    ADD CONSTRAINT labdsp_poll_option_id PRIMARY KEY (poll_option_id);


--
