-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_poll_option labkc_poll_option_id
-- Type: CONSTRAINT

-- Name: labkc_poll_option labkc_poll_option_id; Type: CONSTRAINT; Schema: labkc; Owner: -
--

ALTER TABLE ONLY labkc.labkc_poll_option
    ADD CONSTRAINT labkc_poll_option_id PRIMARY KEY (poll_option_id);


--
